package models

type VehicleType struct {
	ID          int    `gorm:"primarykey;autoIncrement"`
	Name        string `json:"name"`
	Description string `json:"description"`
}
