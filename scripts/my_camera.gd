extends Camera2D

@export var speed: float = 2  # Speed of the camera movement
@export var threshold_value: float = 100.0  # Speed of the camera movement
var target := Vector2()  # Target position

var move_zone_start: Vector2;

func _ready():
	var size = get_viewport_rect().size;
	var end_x = size.x / zoom.x * 0.5 - threshold_value;
	var end_y = size.y / zoom.y * 0.5 - threshold_value;
	var start = Vector2(end_x, end_y)
	
	move_zone_start = start

func _process(delta):
	
	var mouse_pos = get_global_mouse_position()  # Get the global mouse position
	var screen_center = get_screen_center_position()  # Get the center of the screen
	var relative_mouse_pos = mouse_pos-screen_center;
	
	if(abs(relative_mouse_pos.x) >= move_zone_start.x or abs(relative_mouse_pos.y) >= move_zone_start.y):
		position = position.lerp(mouse_pos, speed * delta);
	
func map(value, istart, istop, ostart, ostop):
	return ostart + (ostop - ostart) * ((value - istart) / (istop - istart))
