package handlers

import (
	"go_bikes/internal/services"
	"net/http"

	"github.com/gin-gonic/gin"
)

type VehicleHandler struct {
	vehicleService services.VehicleService
}

func NewVehicleHandler(vehicleService services.VehicleService) *VehicleHandler {
	return &VehicleHandler{vehicleService: vehicleService}
}

func (h *VehicleHandler) GetVehicles(c *gin.Context) {
	vehicles, err := h.vehicleService.GetAllVehicles()
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

func (h *VehicleHandler) GetVehicleByLocation(c *gin.Context) {
	locationName := c.Query("name")
	if locationName == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "location name is required"})
		return
	}
	vehicles, err := h.vehicleService.GetVehiclesByLocationName(locationName)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "vehicle not found for location " + locationName})
		return
	}
	if vehicles == nil {
		c.JSON(http.StatusNotFound, gin.H{"message": "No vehicles found for the specified location."})
		return
	}
	c.JSON(http.StatusOK, vehicles)
}
