package register

import (
	"Gin-api-server/database"

	"github.com/gin-gonic/gin"
)

// SignUpParam - 파라미터 형식 구조체
type SignUpParam struct {
	ID        string `json:"id" form:"id" query:"id"`
	Pw        string `json:"pw" form:"pw" query:"pw"`
	Name      string `json:"name" form:"name" query:"name"`
	Nick      string `json:"nick" form:"nick" query:"nick"`
	Image_Url string `json:"image_url" form:"image_url" query:"nick"`
	IsManager bool   `json:"manager" form:"manager" query:"manager"`
}

// SignUp - 회원가입
func SignUp(c *gin.Context) {
	u := new(SignUpParam)

	if err := c.Bind(u); err != nil {
		return
	}

	hashpw, err := HashPassword(u.Pw)
	if err != nil {
		c.JSON(500, gin.H{
			"status":  500,
			"message": "hash Error",
		})
		return
	}
	u.Pw = hashpw

	//fmt.Println(u.ID, u.Pw, u.Name, u.IsManager)

	if u.ID == "" || u.Pw == "" || u.Name == "" {
		c.JSON(400, gin.H{
			"message": "모든 값을 입력해주세요.",
		})
		return
	}

	User := &database.User{}
	err = database.DB.Where("user_id = ?", u.ID).Find(User).Error
	if err == nil {
		c.JSON(400, gin.H{
			"message": "이미 사용중인 아이디입니다.",
		})
		return
	}

	imgUrl := "https://cdn.discordapp.com/attachments/1075293243308261426/1088002807229075496/KakaoTalk_Photo_2023-03-22-16-34-26.png"

	User = &database.User{UserID: u.ID, Pw: u.Pw, Nick: u.Nick, Name: u.Name, ImageUrl: imgUrl, IsManager: u.IsManager}
	err = database.DB.Create(User).Error
	if err != nil {
		c.JSON(500, gin.H{
			"message": "회원가입 실패",
		})
		return
	} else {
		c.JSON(200, gin.H{
			"data":    200,
			"message": "회원가입이 완료되었습니다.",
		})
		return
	}
}
