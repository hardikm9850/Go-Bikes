package database

import (
	"fmt"
	"go_bikes/internal/models"
	"go_bikes/internal/utils"
	"log"
	"os"
	"path/filepath"

	_ "github.com/go-sql-driver/mysql"
	"github.com/joho/godotenv"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

//var DB *gorm.DB

func ConnectDatabase() (*gorm.DB, error) {
	dsn := getDSN()
	if dsn == "" {
		return nil, fmt.Errorf("data source name is empty")
	}
	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})

	if err != nil {
		return nil, err
	}

	sqlDB, err := db.DB()
	if err != nil {
		return nil, err
	}
	sqlDB.Ping()
	log.Printf("\nDatabase connection established\n")
	return db, nil
}

func Migrate(db *gorm.DB) error {
	// Drop the table
	err := db.Migrator().DropTable(&models.RegistrationRequest{})
	if err != nil {
		return err
	}

	err = db.AutoMigrate(&models.Vehicle{}, &models.User{}, &models.Booking{}, &models.VehicleType{}, &models.VehicleLocations{}, &models.Location{})
	if err != nil {
		return err
	}
	return nil
}

/**
    Get the MySQL DSN from the environment variables.
    If the environment variables are not set, it will panic.
    Returns the MySQL DSN string.
    Example:
    user=your_username
    password=your_password
	dsn stands for data source name. It specifies database location.
*/
func getDSN() string {
	pwd, err := os.Getwd()
	if err != nil {
		panic(err)
	}

	err = godotenv.Load(filepath.Join(pwd, "../.env"))
	if err != nil {
		log.Fatal("Error loading .env file", err)
	}

	user := utils.GetValueFromKey("MYSQL_USER")
	password := utils.GetValueFromKey("MYSQL_PASSWORD")
	host := utils.GetValueFromKey("MYSQL_HOST")
	port := utils.GetValueFromKey("MYSQL_PORT")
	dbname := os.Getenv("MYSQL_DATABASE")

	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=True&loc=Local",
		user, password, host, port, dbname)
	fmt.Println(dsn)
	return dsn
}
