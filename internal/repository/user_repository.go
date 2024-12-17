package repository

import (
	"errors"
	"go_bikes/internal/auth"
	"go_bikes/internal/models"

	"github.com/go-playground/validator"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

var validate = validator.New()

type UserRepository interface {
	CreateUser(registration models.RegistrationRequest) error
	LoginUser(login models.LoginRequest) (string, error)
	GetAllUsers() ([]models.User, error)
}

type userRepository struct{
	db *gorm.DB
}

func NewUserRepository(db *gorm.DB) UserRepository {
	return &userRepository{db : db}
}

func (u *userRepository) CreateUser(  request models.RegistrationRequest) error {
	err := validate.Struct(request)
	if err != nil {
		// Handle validation errors
		return err
	}
	db := u.db
	var existingUser models.RegistrationRequest
	db.Where("mobile = ?", request.Mobile).Or("email = ?", request.Email).First(&existingUser)
	if existingUser.Mobile == request.Mobile {
		return errors.New("User with " + request.Mobile + " already exists")
	}
	if existingUser.Email == request.Email {
		return errors.New("User with " + request.Email + " already exists")
	}
	var newUser models.User
	newUser.RegistrationRequest = request
	return db.Create(&newUser).Error
}

func (u *userRepository) GetAllUsers( ) ([]models.User, error) {
	var users []models.User
	db := u.db
	result := db.Find(&users)
	return users, result.Error
}

func (u *userRepository) LoginUser( loginRequest models.LoginRequest) (string, error) {
	// Check if user exists in the database
	var dbUser models.User
	db := u.db
	result := db.Where("mobile =?", loginRequest.Mobile).First(&dbUser)
	if result.Error != nil {
		return "", errors.New("user with mobile " + loginRequest.Mobile + " not found")
	}
	// Compare the provided password with the hashed one in the database
	var storedUser = dbUser.RegistrationRequest
	// compares a bcrypt hashed password with its possible plaintext equivalent.
	err := bcrypt.CompareHashAndPassword([]byte(storedUser.Password), []byte(loginRequest.Password))
	if err != nil {
		return "", errors.New("invalid password")
	}

	token, err := auth.GenerateToken(storedUser.ID, storedUser.Role)
	if err != nil {
		return "", errors.New("failed to generate token")
	}
	if err := db.Save(&dbUser).Error; err != nil {
		return "", errors.New("Failed to update token for user " + storedUser.Name)
	}

	return token, nil
}
