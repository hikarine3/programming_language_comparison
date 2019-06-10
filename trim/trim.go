package main
import "fmt"
import "strings"

func main() {
	str := "   aaa    \n\t"
    fmt.Println(strings.TrimSpace(str))
}