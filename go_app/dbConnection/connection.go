package dbConnection

import (
	"fmt"

	"github.com/jmoiron/sqlx"

	"github.com/go-sql-driver/mysql"
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
