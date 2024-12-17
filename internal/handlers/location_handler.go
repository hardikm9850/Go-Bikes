package handlers

import (
	"go_bikes/internal/services"
	"net/http"

	"github.com/gin-gonic/gin"
)

type LocationHandler struct {
	locationService services.LocationService
}

/**
While technically it's okay to pass LocationHandler by value (without a pointer),
passing by pointer is a more common practice when creating handlers.
This avoids the need to copy the struct each time and ensures more consistent behavior,
especially if we later decide to modify fields in the handler.
*/

func NewLocationHandler(locationService services.LocationService) *LocationHandler {
	return &LocationHandler{locationService: locationService}
}

func (locationHandler *LocationHandler) GetLocation(c *gin.Context) {
	locations, err := locationHandler.locationService.GetLocations()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, locations)
}
