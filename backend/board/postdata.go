package board

import (
	"Gin-api-server/database"
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt"
)

// 게시물 DB에 저장된 값 list로 출력
func PostBoard(c *gin.Context) {
	var posts []database.Board
	database.DB.Find(&posts)

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

		c.JSON(http.StatusOK, gin.H{
			"data": posts,
		})
		return
	}

	// c.JSON(http.StatusOK, gin.H{
	// 	"data": posts,
	// })
	// return
}

func DetailPostBoard(c *gin.Context) {
	var posts []database.Board
	qCategory := c.Query("category")
	detail := database.DB.Where("category = ?", qCategory).Find(&posts)

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

		c.JSON(http.StatusOK, gin.H{
			"data": detail,
		})
		return
	}

	// c.JSON(http.StatusOK, gin.H{
	// 	"data": detail,
	// })
	// return
}
