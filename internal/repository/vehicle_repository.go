package repository

import (
	"go_bikes/internal/models"

	"gorm.io/gorm"
)

type VehicleRepository interface {
	CreateVehicle(db *gorm.DB, vehicle models.Vehicle) error
	GetVehicles(db *gorm.DB) ([]models.Vehicle, error)
	GetVehicleByID(db *gorm.DB, id int) (models.Vehicle, error)
	UpdateVehicle(db *gorm.DB, id int, newVehicle models.Vehicle) error
	DeleteVehicle(db *gorm.DB, id int) error
}

type vehicleRepository struct{}

// CreateVehicle implements VehicleRepository.
func (v *vehicleRepository) CreateVehicle(db *gorm.DB, vehicle models.Vehicle) error {
	result := db.Create(&vehicle)
	return result.Error
}

// GetVehicles implements VehicleRepository.
func (v *vehicleRepository) GetVehicles(db *gorm.DB) ([]models.Vehicle, error) {
	var vehicles []models.Vehicle
	result := db.Find(&vehicles)
	return vehicles, result.Error
}

func (v *vehicleRepository) GetVehicleByID(db *gorm.DB, id int) (models.Vehicle, error) {
	var vehicle models.Vehicle
	result := db.First(&vehicle, id)
	if result.Error != nil {
		return vehicle, result.Error
	}
	return vehicle, nil
}

func (v *vehicleRepository) UpdateVehicle(db *gorm.DB, id int, newVehicle models.Vehicle) error {
	result := db.Model(&models.Vehicle{}).Where("id = ?", id).Updates(newVehicle)
	return result.Error
}

func (v *vehicleRepository) DeleteVehicle(db *gorm.DB, id int) error {
	result := db.Delete(&models.Vehicle{}, id)
	return result.Error
}

/**
* This pattern is commonly used in Go to create factories or constructors for interfaces, allowing for easy dependency injection and testing.
* By returning &vehicleRepository{}, the NewVehicleRepository function creates
* a new instance of the vehicleRepository struct and returns a pointer to it.
* This allows other parts of the codebase to use the VehicleRepository interface to interact with the vehicleRepository type.
 */
func NewVehicleRepository() VehicleRepository {
	return &vehicleRepository{}
}
