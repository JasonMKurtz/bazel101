package b

import "testing"

func TestFoo(t *testing.T) {
	want := "Foo"
	if got := Foo(); got != want {
		t.Errorf("Expected %s, got %s", want, got)
	}
}
