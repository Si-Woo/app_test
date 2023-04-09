package database

import (
	"time"
)

// User - 유저 관리 테이블
type User struct {
	// Uuid      uint      `gorm:"primary_key; auto_increment:true" json:"uuid"`
	UserID    string    `gorm:"type:varchar(255);unique;not null" json:"user_id"`
	Pw        string    `gorm:"type:varchar(255);not null" json:"pw"`
	Name      string    `gorm:"type:varchar(255);not null" json:"name"`
	Nick      string    `gorm:"type:varchar(255);not null" json:"nick"`
	ImageUrl  string    `gomr:"type:varchar(255);" json:"imageUrl"`
	IsManager bool      `gorm:"not null" sql:"DEFAULT:false" json:"is_manager"`
	JoinedAt  time.Time `gorm:"nor null" sql:"DEFAULT:current_timestamp" json:"joined_at"`
	LoginAt   time.Time `gorm:"nor null" sql:"DEFAULT:current_timestamp" json:"login_at"`
}

// Message 모델
// type Message struct {
// 	gorm.Model
// 	From    string `json:"from"`
// 	To      string `json:"to"`
// 	Content string `json:"content"`
// }

// // ChatRoomManager 구조체
// type ChatRoomManager struct {
// 	rooms map[string]*ChatRoom
// }

// // ChatRoom 구조체
// type ChatRoom struct {
// 	users map[string]*User
// 	conns map[*websocket.Conn]bool
// }
