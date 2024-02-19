extends Node

var cursor = load("res://assets/cursor.png");

func _ready():
	Input.set_custom_mouse_cursor(cursor);
