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
	CreateUser(db *gorm.DB, registration models.RegistrationRequest) error
	LoginUser(db *gorm.DB, login models.LoginRequest) (string, error)
	GetAllUsers(db *gorm.DB) ([]models.User, error)
}

type userRepository struct{}

func NewUserRepository() UserRepository {
	return &userRepository{}
}

func (u *userRepository) CreateUser(db *gorm.DB, request models.RegistrationRequest) error {
	err := validate.Struct(request)
	if err != nil {
		// Handle validation errors
		return err
	}
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

func (u *userRepository) GetAllUsers(db *gorm.DB) ([]models.User, error) {
	var users []models.User
	result := db.Find(&users)
	return users, result.Error
}

func (u *userRepository) LoginUser(db *gorm.DB, loginRequest models.LoginRequest) (string, error) {
	// Check if user exists in the database
	var dbUser models.User

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
