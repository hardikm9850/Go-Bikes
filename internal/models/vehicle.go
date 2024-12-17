package models

type Vehicle struct {
	ID              int         `gorm:"primarykey;autoIncrement"`
	Model           string      `json:"model"`
	Year            int         `json:"year"`
	TypeId          int64         `json:"type"`
	Available       bool        `json:"available"`
	BookedTillDate  string      `json:"booked_till_date"`
	PricePerHour    float64     `json:"price_per_hour"`
	Image           string      `json:"image"`
	VehicleType     VehicleType `gorm:"foreignKey:TypeId;references:TypeID" json:"-"`
	VehicleTypeName string      `json:"vehicle_type_name"`
}

func (Vehicle) TableName() string {
	return "vehicles"
}