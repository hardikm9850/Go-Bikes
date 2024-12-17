package services

import (
	"go_bikes/internal/models"
	"go_bikes/internal/repository"
)

type LocationService interface {
	GetLocations() ([]models.Location, error)
}

type LocationServiceImpl struct {
	locationRepo repository.LocationRepository
}

func NewLocationService(locationRepo repository.LocationRepository) LocationService {
	return &LocationServiceImpl{locationRepo: locationRepo}
}

func (s *LocationServiceImpl) GetLocations() ([]models.Location, error) {
	locations, err := s.locationRepo.GetLocation()
	return locations, err
}
