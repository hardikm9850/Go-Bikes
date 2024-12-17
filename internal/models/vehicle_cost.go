package models

import (
	"time"
)

// VehicleCost represents the vehicle cost structure in the database.
type VehicleCost struct {
	ID                int64     `gorm:"primarykey;autoIncrement" json:"id"`
	VehicleID         int64     `gorm:"not null" json:"vehicle_id"`    // Foreign key to vehicles table
	BasePrice         float64   `gorm:"not null" json:"base_price"`    // Base price for the vehicle
	HourlyRate        float64   `gorm:"not null" json:"hourly_rate"`   // Hourly rate for the vehicle
	KmLimit           int64     `gorm:"not null" json:"km_limit"`      // KM limit for the vehicle
	ExtraRatePerKm    float64   `gorm:"not null" json:"extra_rate_per_km"` // Extra charge per km if it exceeds the km limit
	DailyRate         float64   `gorm:"not null" json:"daily_rate"`    // Daily rate for the vehicle
	StartTime         time.Time `gorm:"not null" json:"start_time"`    // Start time for hourly rate
	EndTime           time.Time `gorm:"not null" json:"end_time"`      // End time for hourly rate
	Vehicle           Vehicle   `gorm:"foreignKey:VehicleID;references:ID" json:"vehicle"` // Associated vehicle details
}

func (VehicleCost) TableName() string {
	return "vehicle_costs"
}