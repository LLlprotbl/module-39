package pkg

import "strings"

const vscSeparator = ","

func someHelperFunction(s string) []string {
	return strings.Split(s, vscSeparator)
}
