package models

type VehicleLocations struct {
	ID         uint   `gorm:"primarykey;autoIncrement"`
	VehicleId  int    `json:"vehicle_id"`
	LocationId int    `json:"location_id"`
	Available  string `json:"available"`
}

func (VehicleLocations) TableName() string {
	return "vehicle_location"
}
