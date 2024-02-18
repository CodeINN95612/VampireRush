extends Control

signal Escaped;

var shown = true;

func _ready():
	hide();

func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause();

func _notification(what):
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
		shown = true;
		_pause();

func _on_resume_button_up():
	toggle_pause();
	
func toggle_pause():
	shown = !shown;
	
	if shown:
		_pause();
	else:
		_unpause();

func _on_quit_button_up():
		get_tree().quit();
		
func _pause():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true;
	show();
	
func _unpause():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	get_tree().paused = false;
	hide();
