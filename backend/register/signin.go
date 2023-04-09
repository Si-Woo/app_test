package register

import (
	"Gin-api-server/database"
	"Gin-api-server/jwt"
	"time"

	"github.com/gin-gonic/gin"
)

// SigninParam - 파라미터 형식 구조체
type SigninParam struct {
	ID      string    `json:"id" form:"id" query:"id"`
	Pw      string    `json:"pw" form:"pw" query:"pw"`
	LoginAt time.Time `json:"login_At" form:"login_At" query:"login_At"`
}

// Signin - 로그인 메서드
func Signin(c *gin.Context) {
	u := new(SigninParam)

	if err := c.Bind(u); err != nil {
		return
	}

	User := &database.User{}
	result := database.DB.Where("user_id = ?", u.ID).Find(User)
	if result.RowsAffected == 0 {
		println("등록되지 않은 유저입니다.")
	}

	inputpw := User.Pw
	res := CheckPasswordHash(inputpw, u.Pw)
	if !res {
		c.JSON(400, gin.H{
			"status":       400,
			"message":      "비밀번호가 일치하지 않습니다.",
			"refreshToken": "null",
			"accessToken":  "null",
		})
		return
	}
	//err := database.DB.Where("user_id = ?", u.ID).Find(User).Error
	//if err != nil {
	//	c.JSON(500, gin.H{
	//		"status":       500,
	//		"message":      "일치하는 회원이 없습니다.",
	//		"refreshToken": "null",
	//		"accessToken":  "null",
	//	})
	//	return
	//}

	// fmt.Println(User.UserID, User.Name)

	refreshToken, err := jwt.CreateRefreshToken(User.UserID)
	if err != nil {
		c.JSON(500, gin.H{
			"status":       500,
			"message":      "refreshtoken 생성 중 에러",
			"refreshToken": "null",
			"accessToken":  "null",
		})
		return
	}

	accessToken, err := jwt.CreateAccessToken(User.UserID, User.IsManager)
	if err != nil {
		c.JSON(500, gin.H{
			"status":       500,
			"message":      "accesstoken 생성 중 에러",
			"refreshToken": refreshToken,
			"accessToken":  "null",
		})
		return
	}

	c.Writer.Header().Add("authorization", accessToken)
	c.Writer.Header().Add("refresh-token", refreshToken)
	// c.SetCookie("access-token", accessToken, 60*60, "/", "localhost:3000", false, true)
	// c.SetCookie("refresh-token", refreshToken, 60*60*24*30, "/", "localhost:3000", false, true)

	loginTime := time.Now()
	// 로그인 시간 저
	err = database.DB.Model(&User).Where("user_id = ?", u.ID).Update("login_at", loginTime).Error
	if err != nil {
		c.JSON(500, gin.H{
			"message": "접속시간error",
		})
	}

	c.JSON(200, gin.H{
		"status":       200,
		"message":      "토큰 발급 완료",
		"refreshToken": refreshToken,
		"accessToken":  accessToken,
		"exp":          time.Now(),
	})
	return
}
