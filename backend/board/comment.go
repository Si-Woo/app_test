package board

import (
	"Gin-api-server/database"
	"fmt"
	"time"

	"github.com/gin-gonic/gin"
)

type CommentParam struct {
	UserID    string    `json:"user_id"`
	CommentID int       `json:"comment_id"`
	Comment   string    `json:"comment"`
	DateTime  time.Time `json:"datetime"`
}

func AddComment(c *gin.Context) {
	u := new(CommentParam)

	if err := c.Bind(u); err != nil {
		return
	}

	fmt.Println(u.UserID, u.CommentID, u.Comment)

	if u.Comment == "" {
		c.JSON(400, gin.H{
			"status":  400,
			"message": "댓글을 입력해주세요.",
		})
		return
	}

	// Comment := &database.Comment{}
	// err := database.DB.Where("user_id = ? AND content = ?", u.UserID, u.Comment).Find(Comment).Error
	// if err == nil {
	// 	c.JSON(400, gin.H{
	// 		"status":  400,
	// 		"message": "이미 중복된 댓글입니다.",
	// 	})
	// 	return
	// }

	// Comment = &database.Comment{CommentID: u.CommentID, UserID: u.UserID, Comment: u.Comment}
	// err = database.DB.Create(Comment).Error
	// if err != nil {
	// 	c.JSON(500, gin.H{
	// 		"status":  500,
	// 		"message": "댓글 등록 실패",
	// 	})
	// 	return
	// }

	c.JSON(200, gin.H{
		"status":  200,
		"message": "댓글 등록완료.",
	})
	return

}

func DeleteComment(c *gin.Context) {
	u := new(CommentParam)

	if err := c.Bind(u); err != nil {
		return
	}

	Comment := &database.Comment{CommentID: u.CommentID}
	err := database.DB.Delete(Comment).Error
	if err != nil {
		c.JSON(500, gin.H{
			"status":  500,
			"message": "게시글 삭제 실패",
		})
		return
	} else {
		c.JSON(200, gin.H{
			"status":  200,
			"message": "게시글 삭제 완료",
		})
		return
	}
}
