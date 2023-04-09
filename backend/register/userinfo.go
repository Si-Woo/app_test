package register

import (
	"Gin-api-server/database"
	"fmt"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt"
)

const secretKey = "secret"

//type UserInfoParam struct {
//	ID   string `json:"id" form:"id" query:"id"`
//	Name string `json:"name" form:"name" query:"name"`
//}

//func GetUserId(c *gin.Context) {
//	u := new(UserInfoParam)
//
//	if err := c.Bind(u); err != nil {
//		return
//	}
//
//	User := &database.User{}
//	userinfo := c.Query("user_id")
//	err := database.DB.Where("user_id = ?", userinfo).Find(&User).Error
//	if err != nil {
//		c.JSON(404, gin.H{
//			"message": "유저정보 불러오기 실패",
//		})
//	} else {
//		c.JSON(http.StatusOK, gin.H{
//			"data": userinfo,
//		})
//	}
//}

func CurrentUser(c *gin.Context) {
	var infos []database.User
	qUserInfo := c.Query("user_id")
	detail := database.DB.Where("user_id = ?", qUserInfo).Find(&infos)

	htoken := c.GetHeader("access-token") //엑세스토큰
	fmt.Println(htoken)

	if htoken == "" {
		c.JSON(401, gin.H{
			"status":  401,
			"message": "token is None.",
		})
		return
	}

	claims := jwt.MapClaims{}

	token, err := jwt.ParseWithClaims(htoken, &claims, func(token *jwt.Token) (interface{}, error) {
		return []byte(secretKey), nil
	})

	if err != nil {
		c.JSON(401, gin.H{
			"status":  401,
			"message": "토큰 인증 실패. 토큰을 재발급 받으세요.(한번 재발급 받았다면 다시 로그인 그렇지않다면 재발급요청)", // Client에서 이 메세지를 받고 accessToken을 재발급 받기위해 refreshToken을 보내며 재발급 요청.
		})
		return
	} else if detail == nil {
		c.JSON(500, gin.H{
			"message": "error",
		})
		return
	} else {
		fmt.Printf("token : %v\n", token)

		for key, val := range claims {
			fmt.Printf("Key : %v, value : %v\n", key, val)
		}

		c.JSON(200, gin.H{
			"data": detail,
		})
		return
	}

	// if detail == nil {
	// 	c.JSON(500, gin.H{
	// 		"message": "error",
	// 	})
	// } else {
	// 	c.JSON(200, gin.H{
	// 		"data": detail,
	// 	})
	// }
}

func ConnectUserList(c *gin.Context) {
	var users []database.User
	database.DB.Order("login_At desc").Find(&users)
	// desc 감소, asc는 증가

	htoken := c.GetHeader("access-token") //엑세스토큰
	fmt.Println(htoken)

	if htoken == "" {
		c.JSON(401, gin.H{
			"status":  401,
			"message": "token is None.",
		})
		return
	}

	claims := jwt.MapClaims{}

	token, err := jwt.ParseWithClaims(htoken, &claims, func(token *jwt.Token) (interface{}, error) {
		return []byte(secretKey), nil
	})

	if err != nil {
		c.JSON(401, gin.H{
			"status":  401,
			"message": "토큰 인증 실패. 토큰을 재발급 받으세요.(한번 재발급 받았다면 다시 로그인 그렇지않다면 재발급요청)", // Client에서 이 메세지를 받고 accessToken을 재발급 받기위해 refreshToken을 보내며 재발급 요청.
		})
		return
	} else {
		fmt.Printf("token : %v\n", token)

		for key, val := range claims {
			fmt.Printf("Key : %v, value : %v\n", key, val)
		}
		c.JSON(200, gin.H{
			"data": users,
		})
		return
	}

	// c.JSON(200, gin.H{
	// 	"data": users,
	// })
	// return
}
