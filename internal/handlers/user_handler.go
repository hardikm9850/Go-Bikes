package handlers

import (
	"errors"
	"go_bikes/internal/models"
	"go_bikes/internal/services"
	"net/http"

	"go_bikes/internal/utils"

	"github.com/gin-gonic/gin"
)

type UserHandler struct {
	userService services.UserService
}

func NewUserHandler(userService services.UserService) *UserHandler {
	return &UserHandler{userService: userService}
}

func (userHandler *UserHandler) RegisterUser(c *gin.Context) {
	var user models.RegistrationRequest
	if err := c.ShouldBindJSON(&user); err != nil { // binds the JSON request body to the user variable
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request format"})
		return
	}
	err := userHandler.userService.RegisterUser(user)

	if err != nil {
		if err != nil {
			handleError(err, c)
		}
		return
	}
	c.JSON(http.StatusCreated, gin.H{"message": "User registered successfully"})
}

func (userHandler *UserHandler) GetUsers(c *gin.Context) {
	// using the database instance, we try to create the user
	users, err := userHandler.userService.GetAllUsers()
	if err != nil {
		handleError(err, c)
	}
	c.JSON(http.StatusOK, users)
}

func (userHandler *UserHandler) LoginUser(c *gin.Context) {
	var loginRequest models.LoginRequest
	if err := c.ShouldBindJSON(&loginRequest); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "mobile or password is missing"})
		return
	}
	token, err := userHandler.userService.LoginUser(loginRequest)
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

func handleError(err error, c *gin.Context) {
	var apiErr *utils.APIError
	if errors.As(err, &apiErr) {
		c.JSON(apiErr.Code, gin.H{"error": apiErr.Message})
	} else {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "something went wrong"})
	}
}
