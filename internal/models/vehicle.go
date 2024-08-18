package models

type Vehicle struct {
	ID           uint   `gorm:"primarykey;autoIncrement"`
	Model        string  `json:"model"`
	Year         int     `json:"year"`
	Type         string  `json:"type"`
	Availability bool    `json:"availability"`
	PricePerHour  float64 `json:"price_per_hour"`
	Image        string  `json:"image"`
}