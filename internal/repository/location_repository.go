package repository

import (
	"go_bikes/internal/models"

	"gorm.io/gorm"
)

type LocationRepository interface {
	GetLocation() ([]models.Location, error)
}

type locationRepository struct {
	db *gorm.DB
}

func NewLocationRepository(db *gorm.DB) LocationRepository {
	return &locationRepository{db: db}
}

func (locationRepo *locationRepository) GetLocation() ([]models.Location, error) {
	var location []models.Location
	result := locationRepo.db.Find(&location)
	return location, result.Error
}
