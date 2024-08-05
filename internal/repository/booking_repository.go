package repository

import (
	"go_bikes/internal/models"

	"gorm.io/gorm"
)

type BookingRepository interface {
	CreateBooking(db *gorm.DB, booking models.Booking) error
	GetBookings(db *gorm.DB) ([]models.Booking, error)
}

type bookingRepository struct{}

func NewBookingRepository() BookingRepository {
	return &bookingRepository{}
}

func (u *bookingRepository) CreateBooking(db *gorm.DB, booking models.Booking) error {
	result := db.Create(&booking)
	return result.Error
}

func (u *bookingRepository) GetBookings(db *gorm.DB) ([]models.Booking, error) {
	var bookings []models.Booking
	result := db.Find(&bookings)
	return bookings, result.Error
}
