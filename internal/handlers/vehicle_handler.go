package handlers

import (
	"go_bikes/internal/repository"
	"net/http"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type VehicleHandler struct {
	vehicleRepository repository.VehicleRepository
	db                *gorm.DB
}

func NewVehicleHandler(vehicleRepository repository.VehicleRepository, db *gorm.DB) *VehicleHandler {
	return &VehicleHandler{vehicleRepository: vehicleRepository, db: db}
}

func (h *VehicleHandler) GetVehicles(c *gin.Context) {
	vehicles, err := h.vehicleRepository.GetVehicles(h.db)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
	}
	// This 'Preload' joins the VehicleType table based on the foreign key relationship specified in our Vehicle model (i.e., TypeId).
	// The result will be a list of Vehicle records, each with its associated VehicleType populated.
	// How clever is that
	err = h.db.Preload("VehicleType").Find(&vehicles).Error
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"Error retrieving vehicles": err.Error()})
		return
	}
	// Map the VehicleType data into Vehicle struct
	for i := range vehicles {
		vehicles[i].VehicleTypeName = vehicles[i].VehicleType.Name
	}
	c.JSON(http.StatusOK, vehicles)
}
