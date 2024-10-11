package models

type Location struct {
	ID          int    `gorm:"primarykey;autoIncrement" json:"-"`
	Name        string `json:"name"`
}