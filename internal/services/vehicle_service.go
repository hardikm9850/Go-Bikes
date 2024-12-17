package services

import (
	"go_bikes/internal/models"
	"go_bikes/internal/repository"
	"go_bikes/internal/utils"
	"net/http"
)

type VehicleService interface {
	GetAllVehicles() ([]models.Vehicle, error)
	GetVehiclesByLocationName(location string) ([]models.Vehicle, error)
}

type VehicleServiceImpl struct {
	vehicleRepository repository.VehicleRepository
}

func NewVehicleService(vehicleRepository repository.VehicleRepository) VehicleService {
	return &VehicleServiceImpl{vehicleRepository: vehicleRepository}
}

func (s *VehicleServiceImpl) GetAllVehicles() ([]models.Vehicle, error) {
	vehicles, err := s.vehicleRepository.GetAllVehicles()
	if err != nil {
		return nil, utils.NewAPIError(http.StatusInternalServerError, "Error getting all vehicles")
	}
	return vehicles, nil
}

func (s *VehicleServiceImpl) GetVehiclesByLocationName(location string) ([]models.Vehicle, error) {
	vehicles, err := s.vehicleRepository.GetVehiclesByLocationName(location)
	if err != nil {
		return nil, utils.NewAPIError(http.StatusInternalServerError, "Error retrieving vehicles by location: "+location)
	}
	return vehicles, nil
}
