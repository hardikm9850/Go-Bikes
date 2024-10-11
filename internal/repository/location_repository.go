package repository

import (
	"go_bikes/internal/models"
	"gorm.io/gorm"
)

type LocationRepository interface {
	GetLocation(db *gorm.DB) ([]models.Location, error)
}

type locationRepository struct {}

func NewLocationRepository() LocationRepository {
    return &locationRepository{}
}

func (locationRepo *locationRepository) GetLocation(db *gorm.DB) ([]models.Location, error) {
	var location []models.Location
    result := db.Find(&location)
    return location, result.Error
}