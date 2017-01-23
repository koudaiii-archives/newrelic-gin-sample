package main

import (
	"fmt"
	"os"

	"github.com/newrelic/go-agent"
	"github.com/newrelic/go-agent/_integrations/nrgin/v1"
	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	if os.Getenv("NEWRELIC_LICENSE_KEY") != "" {
		cfg := newrelic.NewConfig("Gin App", os.Getenv("NEWRELIC_LICENSE_KEY"))
		cfg.Logger = newrelic.NewDebugLogger(os.Stdout)
		app, err := newrelic.NewApplication(cfg)
		if nil != err {
			fmt.Println(err)
			os.Exit(1)
		}

		r.Use(nrgin.Middleware(app))
	}


	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})
	r.Run() // listen and serve on 0.0.0.0:8080
}
