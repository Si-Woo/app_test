package board

import (
	"Gin-api-server/database"

	"github.com/gin-gonic/gin"
)

const secretKey = "secret"

type WriteParam struct {
	ContentID uint   `json:"post_id" form:"Content_id" query:"post_id"`
	ID        string `json:"id" form:"user_id" query:"id"`
	Nick      string `json:"nick" form:"nick" query:"nick"`
	Title     string `json:"title" form:"title" query:"title"`
	Content   string `json:"content" form:"content" query:"content"`
	Category  string `json:"category" form:"category" query:"category"`
}

func Write(c *gin.Context) {
	u := new(WriteParam)

	if err := c.Bind(u); err != nil {
		return
	}

	if u.Content == "" {
		c.JSON(400, gin.H{
			"status":  400,
			"message": "내용을 입력해주세요.",
		})
		return
	}

	if u.Title == "" {
		c.JSON(400, gin.H{
			"status":  400,
			"message": "제목을 입력해주세요.",
		})
		return
	}

	Board := &database.Board{}
	err := database.DB.Where("user_id = ? AND content = ?", u.ID, u.Content).Find(Board).Error
	if err == nil {
		c.JSON(400, gin.H{
			"status":  400,
			"message": "이미 중복된 게시물입니다.",
		})
		return
	}

	// var nickname string
	// nickname = database.DB.Table("users").Select("nick").Where("user_id = ?", u.ID)

	// var nickname string
	// nickname := database.DB.Table("users").Select("nick").Where("user_id = ?", u.ID)
	Board = &database.Board{UserID: u.ID, Nick: u.Nick, Title: u.Title, Content: u.Content, Category: u.Category}
	err = database.DB.Create(Board).Error
	if err != nil {
		c.JSON(500, gin.H{
			"status":  500,
			"message": "게시물 등록 실패",
		})
		return
	}

	// err = database.DB.Table("users").Select("nick").Where("user_id = ?", u.ID).Update("nick", u.Nick).Error
	// if err != nil {
	// 	c.JSON(500, gin.H{
	// 		"message": "Nick error",
	// 	})
	// }

	c.JSON(200, gin.H{
		"status":  200,
		"message": "게시물 등록 완료",
	})
	return

}

func DeleteWrite(c *gin.Context) {
	u := new(WriteParam)

	if err := c.Bind(u); err != nil {
		return
	}

	Board := &database.Board{ContentID: u.ContentID}
	err := database.DB.Delete(Board).Error
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
