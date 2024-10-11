package handlers

import (
	"fmt"
	"go_bikes/internal/models"
	"go_bikes/internal/repository"
	"net/http"

	"go_bikes/internal/utils"

	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator"
	"gorm.io/gorm"
)

type UserHandler struct {
	userRepository repository.UserRepository
	db             *gorm.DB
	validator      *validator.Validate
}

func NewUserHandler(userRepository repository.UserRepository, db *gorm.DB) *UserHandler {
	return &UserHandler{userRepository: userRepository, db: db, validator: validator.New()}
}

func (userHandler *UserHandler) RegisterUser(c *gin.Context) {
	var user models.RegistrationRequest
	if err := c.ShouldBindJSON(&user); err != nil { // binds the JSON request body to the user variable
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request format"})
		return
	}
	//Set default role
	if user.Role == "" {
		user.Role = "customer" // default role is customer if not provided
	}
	// Validate the fields
	if validationErrors := userHandler.ValidateRequest(user, c); len(validationErrors) > 0 {
		c.JSON(http.StatusBadRequest, gin.H{"errors": validationErrors})
		fmt.Println("Error occurred while creating a user:", validationErrors)
		return
	}

	// Encrypt the password through hashing algorithm
	hashedPassword, err := utils.GenerateHashedString(user.Password)
	if err != nil {
		// Handle error
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	user.Password = string(hashedPassword) // update the user's password with hashed one

	// using the database instance, we try to create the user
	err = userHandler.userRepository.CreateUser(userHandler.db, user)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "User created successfully"})

}

func (userHandler *UserHandler) GetUsers(c *gin.Context) {
	// using the database instance, we try to create the user
	users, err := userHandler.userRepository.GetAllUsers(userHandler.db)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, users)
}

func (userHandler *UserHandler) LoginUser(c *gin.Context) {
	var loginRequest models.LoginRequest
	if err := c.ShouldBindJSON(&loginRequest); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "mobile or password is missing"})
		return
	}
	if validationErrors := userHandler.ValidateRequest(loginRequest, c); len(validationErrors) > 0 {
		c.JSON(http.StatusBadRequest, gin.H{"errors": validationErrors})
		fmt.Println("Error occurred while logging in:", validationErrors)
		return
	}
	token, err := userHandler.userRepository.LoginUser(userHandler.db, loginRequest)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{
			"error":   err.Error(),
			"success": false,
		})
		return
	}
	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"token":   token,
	})
}

// Validate the fields
func (userHandler UserHandler) ValidateRequest(request interface{}, c *gin.Context) []string {
	if err := userHandler.validator.Struct(request); err != nil {
		var validationErrors []string
		for _, err := range err.(validator.ValidationErrors) {
			validationErrors = append(validationErrors, err.Field()+" is "+err.Tag())
		}
		return validationErrors
	}
	return []string{}
}
