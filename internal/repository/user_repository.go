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

func (u *userRepository) CreateUser(db *gorm.DB, registration models.RegistrationRequest) error {
	err := validate.Struct(registration)
	if err != nil {
		// Handle validation errors
		return err
	}
	var existingUser models.RegistrationRequest
	db.Where("mobile = ?", registration.Mobile).Or("email = ?", registration.Email).First(&existingUser)
	if existingUser.Mobile == registration.Mobile {
		return errors.New("" + registration.Mobile + " already exists")
	}
	if existingUser.Email == registration.Email {
		return errors.New("" + registration.Email + " already exists")
	}
	var newUser models.User
	newUser.RegistrationRequest = registration
	return db.Create(&newUser).Error
}

func (u *userRepository) GetAllUsers(db *gorm.DB) ([]models.User, error) {
	var users []models.User
	result := db.Find(&users)
	return users, result.Error
}

func (u *userRepository) LoginUser(db *gorm.DB, login models.LoginRequest) (string, error) {
	// Check if user exists in the database
	var dbUser models.User

	result := db.Where("mobile =?", login.Mobile).First(&dbUser)
	if result.Error != nil {
		return "", result.Error
	}
	// Compare the provided password with the hashed one in the database
	var user = dbUser.RegistrationRequest
	err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(login.Password))
	if err != nil {
		return "", err
	}

	token, err := auth.GenerateToken(user.ID, user.Role)
	if err != nil {
		return "", errors.New("failed to generate token")
	}
	if err := db.Save(&dbUser).Error; err != nil {
		return "", errors.New("Failed to update token for user " + user.Name)
	}

	return token, nil
}
