package database

import (
	"fmt"
	"log"
	"os"

	"github.com/jinzhu/gorm"
	"github.com/joho/godotenv"
)

//type connectionMethod interface {
//	Connect()
//}

// DB - 데이터베이스 전역변수
var DB *gorm.DB

// Connect - 데이터베이스 구조 생성, 연결하는 메서드
func Connect() {

	err := godotenv.Load(".env")
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	host := os.Getenv("DB_HOST")
	port := os.Getenv("DB_PORT")
	user := os.Getenv("DB_USER")
	name := os.Getenv("DB_NAME")
	pw := os.Getenv("DB_PASSWORD")
	// dbConf := config.Config.DB

	connectOptions := fmt.Sprintf("host=%s port=%s user=%s dbname=%s password=%s sslmode=disable",
		host,
		port,
		user,
		name,
		pw)

	db, err := gorm.Open("postgres", connectOptions)

	if err != nil {
		panic(err)
	}

	db.AutoMigrate(
		&User{},
		&Board{},
		&Comment{},
		// &Message{},
	)

	DB = db

	log.Print("[DATABASE 연결 완료]")
}
