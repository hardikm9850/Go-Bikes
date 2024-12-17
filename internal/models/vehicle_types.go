package models

type VehicleType struct {
	TypeID          int64    `gorm:"primarykey;autoIncrement"`
	Name        string `json:"name"`
	Description string `json:"description"`
}

func (VehicleType) TableName() string {
	return "vehicle_types"
}
