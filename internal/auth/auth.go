package auth

import (
	"time"
	"github.com/golang-jwt/jwt/v5"
	"go_bikes/internal/utils"
)

type Claims struct {
	jwt.RegisteredClaims
	UserID uint
	Role   string
}

func GenerateToken(userID uint, role string) (string, error) {
	claims := Claims{
		RegisteredClaims: jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(time.Hour * 24)),
			Issuer:    "GoBikes",
		},
		UserID: userID,
		Role:   role,
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

	secretKey, _ := utils.GetSecretKey()

	tokenString, err := token.SignedString([]byte(secretKey))
	if err != nil {
		return "", err
	}

	return tokenString, nil
}