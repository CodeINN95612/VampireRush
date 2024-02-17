extends Node

var cursor = load("res://assets/cursor.png");

func _ready():
	Input.set_custom_mouse_cursor(cursor);
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED);


#func _process(delta):
	#pass
