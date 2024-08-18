package models

import "time"

type Booking struct {
	ID         uint      `gorm:"primarykey;autoIncrement"`
	VehicleID  int       `json:"vehicle_id"`
	UserID     int       `json:"user_id"`
	StartDate  time.Time `json:"start_date"`
	EndDate    time.Time `json:"end_date"`
	TotalPrice float64   `json:"total_price"`
	Status     string    `json:"status"`
}
