package models

type Location struct {
	LocationID int    `gorm:"primarykey;autoIncrement" json:"-"`
	Name       string `json:"name"`
}

func (Location) TableName() string {
	return "locations"
}

// get location list {} - returns all locations with location id
// get vehicle_list by location id {}
// 