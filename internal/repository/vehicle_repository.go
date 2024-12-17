package repository

import (
	"go_bikes/internal/models"

	"gorm.io/gorm"
)

type VehicleRepository interface {
	CreateVehicle(vehicle models.Vehicle) error
	GetAllVehicles() ([]models.Vehicle, error)
	GetVehicleByID(id int) (models.Vehicle, error)
	GetVehiclesByLocationName(locationName string) ([]models.Vehicle, error)
	UpdateVehicle(id int, newVehicle models.Vehicle) error
	DeleteVehicle(id int) error
}

type vehicleRepository struct {
	db *gorm.DB
}

// CreateVehicle implements VehicleRepository.
func (v *vehicleRepository) CreateVehicle(vehicle models.Vehicle) error {
	result := v.db.Create(&vehicle)
	return result.Error
}

// GetVehicles implements VehicleRepository.
func (v *vehicleRepository) GetAllVehicles() ([]models.Vehicle, error) {
	var vehicles []models.Vehicle
	// Preload the VehicleType to populate the VehicleTypeName field
	result := v.db.Preload("VehicleType").Find(&vehicles)

	// Assign VehicleTypeName manually from VehicleType
	for i := range vehicles {
		vehicles[i].VehicleTypeName = vehicles[i].VehicleType.Name // Assuming `Name` is a field in `VehicleType`
	}

	return vehicles, result.Error
}

func (v *vehicleRepository) GetVehicleByID(id int) (models.Vehicle, error) {
	var vehicle models.Vehicle
	result := v.db.First(&vehicle, id)
	if result.Error != nil {
		return vehicle, result.Error
	}
	return vehicle, nil
}

func (v *vehicleRepository) GetVehiclesByLocationName(locationName string) ([]models.Vehicle, error) {
	var vehicles []models.Vehicle

	query := `
    SELECT vehicles.* 
    FROM vehicles 
    INNER JOIN vehicle_location ON vehicle_location.vehicle_id = vehicles.id 
    INNER JOIN locations ON locations.location_id = vehicle_location.location_id
	INNER JOIN vehicle_costs ON vehicle_costs.vehicle_id = vehicles.id 
    WHERE locations.name = ?
	`
	result := v.db.Raw(query, locationName).Scan(&vehicles)

	if result.Error != nil {
		return nil, result.Error
	}

	return vehicles, nil
}

func (v *vehicleRepository) UpdateVehicle(id int, newVehicle models.Vehicle) error {
	result := v.db.Model(&models.Vehicle{}).Where("id = ?", id).Updates(newVehicle)
	return result.Error
}

func (v *vehicleRepository) DeleteVehicle(id int) error {
	result := v.db.Delete(&models.Vehicle{}, id)
	return result.Error
}

/**
* This pattern is commonly used in Go to create factories or constructors for interfaces, allowing for easy dependency injection and testing.
* By returning &vehicleRepository{}, the NewVehicleRepository function creates
* a new instance of the vehicleRepository struct and returns a pointer to it.
* This allows other parts of the codebase to use the VehicleRepository interface to interact with the vehicleRepository type.
 */
func NewVehicleRepository(db *gorm.DB) VehicleRepository {
	return &vehicleRepository{db: db}
}
