package repository

import (
	"go_bikes/internal/models"

	"github.com/go-playground/validator"
	"gorm.io/gorm"
)

var validate = validator.New()

type UserRepository interface {
	CreateUser(db *gorm.DB, user models.User) error
	GetAllUsers(db *gorm.DB) ([]models.User, error)
}

type userRepository struct{}

func NewUserRepository() UserRepository {
	return &userRepository{}
}

func (u *userRepository) CreateUser(db *gorm.DB, user models.User) error {
	err := validate.Struct(user)
	if err != nil {
		// Handle validation errors
		return err
	}
	result := db.Create(&user)
	return result.Error
}

func (u *userRepository) GetAllUsers(db *gorm.DB) ([]models.User, error) {
	var users []models.User
	result := db.Find(&users)
	return users, result.Error
}
