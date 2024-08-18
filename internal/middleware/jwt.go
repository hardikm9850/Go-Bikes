package middleware

import (
	"go_bikes/internal/utils"
	"log"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v5"
)

type Claims struct {
	jwt.RegisteredClaims
	UserID uint
	Role   string
}

func JWTMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		authHeader := c.GetHeader("Authorization")
		if authHeader == "" {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "authorization header required"})
			c.Abort()
			return
		}
		// Trim whitespace and split the header
		parts := strings.Split(strings.TrimSpace(authHeader), " ")
		tokenString := parts[1]
		log.Printf("jwt token received : ", tokenString)
		// Parse and verify token
		token, err := jwt.ParseWithClaims(tokenString, &Claims{}, func(token *jwt.Token) (interface{}, error) {
			secretKey, _ := utils.GetSecretKey()
			return []byte(secretKey), nil
		})
		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "invalid token"})
			c.Abort()
			return
		}

		if claims, ok := token.Claims.(*Claims); ok && token.Valid {
			log.Printf("token is valid ")
			// Add user ID to context
			c.Set("user_id", claims.UserID)
			c.Next()
		} else {
			log.Printf("token is invalid ")
			c.JSON(http.StatusUnauthorized, gin.H{"error": "invalid token"})
			c.Abort()
		}
	}
}
