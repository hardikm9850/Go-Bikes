package utils

import (
	"os"
	"path/filepath"

	"github.com/joho/godotenv"
	"golang.org/x/crypto/bcrypt"
)

var envLoaded bool

func GetSecretKey() (string, error) {
	return GetValueFromKey("JWT_SECRET_KEY"), nil
}

func GetValueFromKey(key string) string {
	// Check if we're in development environment
	isDevelopment := os.Getenv("APP_ENV") == "development"
	// Load .env file only in development
	if isDevelopment && !envLoaded {
		pwd, err := os.Getwd()
		if err != nil {
			return ""
		}
		err = godotenv.Load(filepath.Join(pwd, "../.env"))
		if err != nil {
			panic("Error loading .env file")
		}
		envLoaded = true
	}
	return os.Getenv(key)
}

func GenerateHashedString(candidate string) (string, error) {
	hashedCandidate, err := bcrypt.GenerateFromPassword([]byte(candidate), bcrypt.DefaultCost)
	return string(hashedCandidate), err
}
