package database

import "time"

// Content - 게시물 관리 테이블
type Board struct {
	ContentID uint      `gorm:"primary_key; auto_increment:true" json:"content_id"`
	UserID    string    `gorm:"type:varchar(255);not null" json:"user_id"`
	Nick      string    `gorm:"type:varchar(255);not null" json:"nick"`
	Title     string    `gorm:"type:varchar(255);not null" json:"title"`
	Content   string    `gorm:"type:varchar(255);not null" json:"content"`
	Category  string    `gorm:"type:varchar(255);not null" json:"category"`
	CreatedAt time.Time `gorm:"nor null" sql:"DEFAULT:current_timestamp" json:"created_at"`
}

// Comment - 댓글 관리 테이블
type Comment struct {
	CommentID int       `gorm:"primary_key; auto_increment:true" json:"comment_id"`
	UserID    string    `json:"user_id"`
	Nick      string    `json:"nick"`
	Comment   string    `gorm:"type:varchar(255);not null" json:"comment"`
	CreatedAt time.Time `gorm:"nor null" sql:"DEFAULT:current_timestamp" json:"created_at"`
}
