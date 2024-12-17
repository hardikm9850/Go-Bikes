package main

import (
	"fmt"
	"go_bikes/internal/database"
	"go_bikes/internal/handlers"
	"go_bikes/internal/middleware"
	"go_bikes/internal/repository"
	"go_bikes/internal/services"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func main() {
	db, err := prepareDatabase()
	if err != nil {
		fmt.Println("Error connecting to database ", err)
		return
	}
	prepareConnection(db)
}

func prepareDatabase() (*gorm.DB, error) {
	db, err := database.ConnectDatabase()
	if err != nil {
		return nil, err
	}
	return db, nil
}

func prepareConnection(db *gorm.DB) {
	// Database handlers
	userRepository := repository.NewUserRepository(db)
	vehicleRepository := repository.NewVehicleRepository(db)
	locationRepository := repository.NewLocationRepository(db)


	// Service layer entities	
	userService := services.NewUserService(userRepository)
	vehicleService := services.NewVehicleService(vehicleRepository)
	locationService := services.NewLocationService(locationRepository)
	

	// Http request handlers
	userHandler := handlers.NewUserHandler(userService)
	vehicleHandler := handlers.NewVehicleHandler(vehicleService)
	locationHandler := handlers.NewLocationHandler(locationService)


	// init Gin router
	r := gin.Default()
	
	r.SetTrustedProxies([]string{"127.0.0.1", "192.168.1.2", "10.0.0.0/8"})
	r.GET("/", func(ctx *gin.Context) {
		ctx.JSON(200, gin.H{
			"message": "Welcome to the Bike Shop API",
		})
	})
	r.POST("/register", userHandler.RegisterUser)
	r.POST("/login", userHandler.LoginUser)

	// User handler
	protectedUser := r.Group("/users")
	protectedUser.Use(middleware.JWTMiddleware())
	protectedUser.GET("/", func(c *gin.Context) {
		userHandler.GetUsers(c)
	})

	// Vehicle handler
	protectedVehicles := r.Group("/vehicles")
	protectedVehicles.Use(middleware.JWTMiddleware())
	protectedVehicles.GET("/", func(c *gin.Context) {
		vehicleHandler.GetVehicles(c)
	})
	protectedVehicles.GET("/location", func(c *gin.Context) {
		vehicleHandler.GetVehicleByLocation(c)
	})

	// Location handler
	protectedLocations := r.Group("/locations")
	protectedLocations.Use(middleware.JWTMiddleware())
	protectedLocations.GET("/", func(c *gin.Context) {
		locationHandler.GetLocation(c)
	})

	r.Run(":8080")
}
