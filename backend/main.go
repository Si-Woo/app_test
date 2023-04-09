package main

import (
	"Gin-api-server/board"
	"Gin-api-server/database"
	"Gin-api-server/jwt"
	"Gin-api-server/middleware"
	"Gin-api-server/register"
	"log"
	"os"

	"github.com/gin-gonic/gin"
	_ "github.com/jinzhu/gorm/dialects/postgres"
	"github.com/joho/godotenv"
)

func main() {
	// config.InitConfig()
	database.Connect()

	r := gin.Default()

	r.Use(middleware.CORSmiddleware())

	r.GET("/server-test", register.ServerTest)

	// 로그인 관련
	r.GET("/userlist", register.ConnectUserList)
	r.GET("/currentuser", register.CurrentUser)
	r.POST("/signup", register.SignUp)
	r.POST("/signin", register.Signin)
	r.POST("logout", register.Logout)
	// r.POST("/token-test", jwt.VerifyAccessToken, register.TokenTest)
	r.POST("/re-token", jwt.VerifyRefreshToken, jwt.CreateReissuanceToken)

	// 게시물 관련
	r.GET("/board", board.PostBoard)
	r.GET("/board/list", board.DetailPostBoard)
	r.POST("/write", board.Write)
	r.POST("/comment", board.AddComment)
	r.DELETE("/delcomment", board.DeleteComment)
	r.DELETE("/delwrite", board.DeleteWrite)

	// 채팅 관련
	err := godotenv.Load(".env")
	if err != nil {
		log.Fatal("Error loading .env file")
	}
	api_server := os.Getenv("API_SERVER")
	r.Run(api_server)
}
