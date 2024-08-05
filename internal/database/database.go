package database

import (
	"fmt"
	"go_bikes/internal/models"
	"log"
	"os"

	"path/filepath"

	_ "github.com/go-sql-driver/mysql"
	"github.com/joho/godotenv"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

var DB *gorm.DB

func Connect() (*gorm.DB, error) {
	// dsn stands for data source name. It specifies database location.
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
	DB = db
	log.Printf("\nDatabase connection established\n")
	return db, nil
}

func Migrate(db *gorm.DB) error {
	// Drop the table
	err := db.Migrator().DropTable(&models.User{})
	if err != nil {
		return err
	}

	err = db.AutoMigrate(&models.Vehicle{}, &models.User{}, &models.Booking{})
	if err != nil {
		return err
	}
	return nil
}

func getDSN() string {
	pwd, err := os.Getwd()
	if err != nil {
		panic(err)
	}

	err = godotenv.Load(filepath.Join(pwd, "../.env"))
	if err != nil {
		log.Fatal("Error loading .env file", err)
	}

	user := os.Getenv("MYSQL_USER")
	password := os.Getenv("MYSQL_PASSWORD")
	host := os.Getenv("MYSQL_HOST")
	port := os.Getenv("MYSQL_PORT")
	dbname := os.Getenv("MYSQL_DATABASE")

	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=True&loc=Local",
		user, password, host, port, dbname)
	fmt.Println(dsn)
	return dsn
}
