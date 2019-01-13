package main
import "fmt"
func main() {
	array := [3]int{3, 1, 2}
	for _, num := range array {
		fmt.Println(num)
	}
}