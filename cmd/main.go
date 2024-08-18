package main

import (
	"fmt"
	"go_bikes/internal/database"
	"go_bikes/internal/handlers"
	"go_bikes/internal/middleware"
	"go_bikes/internal/repository"
	"log"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func main() {
	db := prepareDatabase()
	prepareConnection(db)
}

func prepareDatabase() (db *gorm.DB) {
	db, err := database.Connect()
	if err != nil {
		fmt.Print(err)
		return
	}
	err = database.Migrate(db)
	if err != nil {
		log.Fatal("failed to migrate database", err)
	}
	return db
}

func prepareConnection(db *gorm.DB) {
	userRepository := repository.NewUserRepository()
	userHandler := handlers.NewUserHandler(userRepository, db)

	// init Gin router
	r := gin.Default()

	r.POST("/register", userHandler.RegisterUser)
	r.POST("/login", userHandler.LoginUser)

	protected := r.Group("/users")
	protected.Use(middleware.JWTMiddleware())
	protected.GET("/", func(c *gin.Context) {
		userHandler.GetUsers(c)
	})

	r.Run(":8080")
}
