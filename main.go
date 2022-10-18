package main

import (
	_ "localhost.localdomain/kjuulh/renovate-minimal-go-submodule/submodule-with-user"
	_ "localhost.localdomain/renovate-minimal-go-submodule"
	_ "localhost.localdomain/renovate-minimal-go-submodule/submodule"
)

func main() {
	println("Hello from root")
}
