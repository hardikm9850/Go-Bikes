package models

import "fmt"

type User struct {
	//To embed a struct within another struct, without GORM treating it as a separate entity, we use gorm:"embedded" tag
	RegistrationRequest `gorm:"embedded"`
}

func (u User) String() string {
	registration := u.RegistrationRequest
	return fmt.Sprintf("[%s, %s, %s, %s]", registration.Name, registration.Email, registration.Mobile, registration.Password)
}

type RegistrationRequest struct {
	ID            uint   `gorm:"primarykey;autoIncrement"`
	Name          string `json:"name" validate:"required"`
	Email         string `json:"email" gorm:"type:varchar(255);unique" validate:"required"`
	Mobile        string `json:"mobile" validate:"required"`
	Address       string `json:"address" validate:"required"`
	LicenseNumber string `json:"license_number" validate:"required"`
	Role          string `json:"role" validate:"oneof=admin customer"` //customer or admin user
	Password      string `json:"password" validate:"required"`
}

type LoginRequest struct {
	Mobile   string `json:"mobile" validate:"required"`
	Password string `json:"password" validate:"required"`
}
