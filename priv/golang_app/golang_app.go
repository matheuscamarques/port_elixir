package main

import (
	"bufio"
	"fmt"
	"os"

	"strings"
)

func main() {
	fmt.Println("Start Golang APP")
	for {
		reader := bufio.NewReader(os.Stdin)
		text, err := reader.ReadString('\n')
		if err != nil {
			os.Exit(1)
		}

		text = strings.Trim(text, "\n")

		if strings.EqualFold(text, "exit") {
			os.Exit(0)
			break
		}

		if strings.EqualFold(text, "hello") {
			fmt.Println("world")
			continue
		}

		// fmt.Println(char, size)
	}
}
