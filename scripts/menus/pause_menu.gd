extends Control

signal Escaped;

var shown = true;

func _ready():
	hide();

func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause();

func _on_resume_button_up():
	toggle_pause();
	
func toggle_pause():
	shown = !shown;
	
	if shown:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		get_tree().paused = false;
		hide();
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true;
		show();

func _on_quit_button_up():
		get_tree().quit();
