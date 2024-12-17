package services

import (
	"go_bikes/internal/models"
	"go_bikes/internal/repository"
	"go_bikes/internal/utils"
	"net/http"

	"github.com/go-playground/validator/v10"
)

type UserService interface {
	RegisterUser(models.RegistrationRequest) error
	GetAllUsers() ([]models.User, error)
	LoginUser(models.LoginRequest) (string, error)
}

type userServiceImpl struct {
	userRepository repository.UserRepository
	validator      *validator.Validate
}

func NewUserService(userRepository repository.UserRepository) UserService {
	return &userServiceImpl{
		userRepository: userRepository,
		validator:      validator.New()}
}

// GetAllUsers implements UserService.
func (s *userServiceImpl) GetAllUsers() ([]models.User, error) {
	users, err := s.userRepository.GetAllUsers()
	if err != nil {
		return nil, utils.NewAPIError(http.StatusInternalServerError, "validation failed while registering user")
	}
	return users, nil
}

// LoginUser implements UserService.
func (s *userServiceImpl) LoginUser(login models.LoginRequest) (string, error) {
	if validationErrors := s.ValidateRequest(login); len(validationErrors) > 0 {
		return "", utils.NewAPIError(http.StatusBadRequest, "error occurred while logging in:")
	}

	token, err := s.userRepository.LoginUser(login)
	if err != nil {
		return "", utils.NewAPIError(http.StatusUnauthorized, "invalid credentials")
	}
	return token, nil
}

func (s *userServiceImpl) RegisterUser(user models.RegistrationRequest) error {
	if user.Role == "" {
		user.Role = "customer" // default role is customer if not provided
	}
	if validationErrors := s.ValidateRequest(user); len(validationErrors) > 0 {
		return utils.NewAPIError(http.StatusBadRequest, "validation failed while registering user")
	}
	// Encrypt the password through hashing algorithm
	hashedPassword, err := utils.GenerateHashedString(user.Password)
	if err != nil {
		return utils.NewAPIError(http.StatusInternalServerError, "internal error during password hashing")
	}
	user.Password = string(hashedPassword) // update the user's password with hashed one

	err = s.userRepository.CreateUser(user)
	if err != nil {
		return utils.NewAPIError(http.StatusInternalServerError, "internal error during storing user")
	}
	return nil
}

func (s *userServiceImpl) ValidateRequest(request interface{}) []string {
	if err := s.validator.Struct(request); err != nil {
		var validationErrors []string
		for _, err := range err.(validator.ValidationErrors) {
			validationErrors = append(validationErrors, err.Field()+" is "+err.Tag())
		}
		return validationErrors
	}
	return []string{}
}
