package handlers

import (
	"go_bikes/internal/models"
	"go_bikes/internal/repository"
	"net/http"

	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

type UserHandler struct {
	userRepository repository.UserRepository
	db             *gorm.DB
}

func NewUserHandler(userRepository repository.UserRepository, db *gorm.DB) *UserHandler {
	return &UserHandler{userRepository: userRepository, db: db}
}

func (h *UserHandler) RegisterUser(c *gin.Context) {
	var user models.RegistrationRequest
	if err := c.ShouldBindJSON(&user); err != nil { // binds the JSON request body to the user variable
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	//Set default role
	if user.Role == "" {
		user.Role = "customer" // default role is customer if not provided
	}
	// Encrypt the password through hashing algorithm
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(user.Password), bcrypt.DefaultCost)
	if err != nil {
		// Handle error
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	user.Password = string(hashedPassword) // update the user's password with hashed one
	
	// using the database instance, we try to create the user
	err = h.userRepository.CreateUser(h.db, user)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "User created successfully"})

}

func (h *UserHandler) GetUsers(c *gin.Context) {
	// using the database instance, we try to create the user
	users, err := h.userRepository.GetAllUsers(h.db)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, users)
}

func (h *UserHandler) LoginUser(c *gin.Context) {
	var loginRequest models.LoginRequest
	if err := c.ShouldBindJSON(&loginRequest); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	token, err := h.userRepository.LoginUser(h.db, loginRequest)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, gin.H{
		"success": true,
		"token":   token,
	})
}
