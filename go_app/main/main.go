package main

import (
	"fmt"
	"log"

	"github.com/jmoiron/sqlx"

	"github.com/go-sql-driver/mysql"
	"github.com/gofiber/fiber/v2"
)

func DbConnection() (*sqlx.DB, error) {
	conf := mysql.Config{
		User:                 "root",
		Passwd:               "dbpassword",
		Addr:                 "localhost:3306",
		DBName:               "db_appointment",
		AllowNativePasswords: true,
	}
	db, err := sqlx.Open("mysql", conf.FormatDSN())

	fmt.Println("Connected")
	if err != nil {
		return nil, err
	}
	return db, nil
}

type User struct {
	First string `json:"first"`
	Last  string `json:"last"`
	Email string `json:"email"`
}

func main() {
	app := fiber.New()
	client, err := DbConnection()
	defer client.Close()
	app.Get("/", func(c *fiber.Ctx) error {
		var user User
		err = client.QueryRow("SELECT * from user WHERE last_name='doe';").Scan(&user.First, &user.Last, &user.Email)
		if err != nil {
			log.Fatal(err)
		}
		return c.JSON(user)
	})

	app.Get("/salut/:name", func(c *fiber.Ctx) error {
		msg := fmt.Sprintf("Hello, %s 👋!", c.Params("name"))
		return c.SendString(msg) // => Hello john 👋!
	})

	app.Listen(":3000")

}
