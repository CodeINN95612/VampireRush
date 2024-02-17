extends Camera2D

@export var min_speed: float = 0  # Speed of the camera movement
@export var max_speed: float = 2  # Speed of the camera movement
var target := Vector2()  # Target position

func _ready():
	target = position  # Initialize target to current camera position

func _process(delta):
	var mouse_pos = get_global_mouse_position()  # Get the global mouse position
	var screen_center = get_screen_center_position()  # Get the center of the screen
	var distance = mouse_pos.distance_to(screen_center)
	var local_speed = map(distance, 0, 300, min_speed, max_speed);
	target = mouse_pos  # Set the target to the mouse position
	position = position.lerp(target, local_speed * delta);
	
func map(value, istart, istop, ostart, ostop):
	return ostart + (ostop - ostart) * ((value - istart) / (istop - istart))
