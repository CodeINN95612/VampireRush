extends Control

func _ready():
	$Panel/MarginContainer/VBoxContainer/Play.connect("pressed", _on_play_pressed)
	$Panel/MarginContainer/VBoxContainer/Options.connect("pressed", _on_options_pressed)
	$Panel/MarginContainer/VBoxContainer/Quit.connect("pressed", _on_quit_pressed)
	pass

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/test_bed.tscn")

func _on_options_pressed():
	print("options")
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
