package models

type User struct {
	ID            uint   `gorm:"primarykey;autoIncrement"`
	Name          string `json:"name" validate:"required"`
	Email         string `json:"email" validate:"required"`
	Mobile        string `json:"mobile" validate:"required"`
	Address       string `json:"address" validate:"required"`
	LicenseNumber string `json:"license_number" validate:"required"`
	Role          string `json:"role" validate:"oneof=admin customer"` //customer or admin user
	Password      string `json:"password" validate:"required"`
}
