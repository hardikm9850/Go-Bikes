package handlers

import (
	"go_bikes/internal/repository"
	"net/http"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type LocationHandler struct {
    locationRepo repository.LocationRepository 
    db                *gorm.DB
}

/**
While technically it's okay to pass LocationHandler by value (without a pointer), 
passing by pointer is a more common practice when creating handlers. 
This avoids the need to copy the struct each time and ensures more consistent behavior, 
especially if we later decide to modify fields in the handler.
*/

func NewLocationHandler(locationRepo repository.LocationRepository, db *gorm.DB) *LocationHandler {
    return &LocationHandler{locationRepo: locationRepo, db: db}
}

func (locationHandler *LocationHandler) GetLocation(c *gin.Context) {
	locations, err := locationHandler.locationRepo.GetLocation(locationHandler.db)
    if err!= nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
        return
    }
    c.JSON(http.StatusOK, locations)
}