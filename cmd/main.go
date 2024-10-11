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
	db, err := database.ConnectDatabase()
	if err != nil {
		printError(err)
		return
	}
	err = database.Migrate(db)
	if err != nil {
		log.Fatal("failed to migrate database", err)
	}
	return db
}

func printError(err error) {
	fmt.Println("Error connecting to database ", err)
}

func prepareConnection(db *gorm.DB) {
	userRepository := repository.NewUserRepository()
	vehicleRepository := repository.NewVehicleRepository()
	locationRepository := repository.NewLocationRepository()

	userHandler := handlers.NewUserHandler(userRepository, db)
	vehicleHandler := handlers.NewVehicleHandler(vehicleRepository, db)
	locationHandler := handlers.NewLocationHandler(locationRepository, db)
	
	// init Gin router
	r := gin.Default()
	r.GET("/", func(ctx *gin.Context) {
		ctx.JSON(200, gin.H{
			"message": "Welcome to the Bike Shop API",
		})
	})
	r.POST("/register", userHandler.RegisterUser)
	r.POST("/login", userHandler.LoginUser)

	protectedUser := r.Group("/users")
	protectedUser.Use(middleware.JWTMiddleware())
	protectedUser.GET("/", func(c *gin.Context) {
		userHandler.GetUsers(c)
	})
	protectedVehicles := r.Group("/vehicles")
	protectedVehicles.Use(middleware.JWTMiddleware())
	protectedVehicles.GET("/", func(c *gin.Context) {
		vehicleHandler.GetVehicles(c)
	})

	protectedLocations := r.Group("/locations")
	protectedLocations.Use(middleware.JWTMiddleware())
	protectedLocations.GET("/", func(c *gin.Context) {
        locationHandler.GetLocation(c)
    })
	

	r.Run(":8080")
}
