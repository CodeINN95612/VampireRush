extends CharacterBody2D

@export var speed: float = 100 # Speed of the camera movement
@export var acceleration: float = 10.0 # Speed of the camera movement
@export var threshold_value: float = 50.0  # Speed of the camera movement
@export var player_node: PlayerVampire

var move_zone_start: Vector2
var looking_for_player: bool

var camera: Camera2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = $Camera2D;
	looking_for_player = false
	
	get_viewport().warp_mouse(get_viewport().size / 2);
	
	var size = get_viewport_rect().size;
	var end_x = size.x / camera.zoom.x * 0.5 - threshold_value;
	var end_y = size.y / camera.zoom.y * 0.5 - threshold_value;
	var start = Vector2(end_x, end_y)
	
	move_zone_start = start
	
func _input(event):
	if event.is_action_pressed("ui_select"):
		var player_pos = player_node.position
		var distance_to_player = position.distance_to(player_pos)
		if distance_to_player > player_node.threshold:
			looking_for_player = true
	
func _physics_process(delta):
	
	if looking_for_player:
		move_to_player(delta)
	else:
		move_to_mouse(delta)
	move_and_slide()
	

func move_to_mouse(delta):
	var mouse_pos = get_global_mouse_position()  # Get the global mouse position
	var screen_center = camera.get_screen_center_position()  # Get the center of the screen
	var relative_mouse_pos = mouse_pos-screen_center;
	
	if(abs(relative_mouse_pos.x) >= move_zone_start.x or abs(relative_mouse_pos.y) >= move_zone_start.y):
		var direction = screen_center.direction_to(mouse_pos);
		velocity = velocity.lerp(direction * speed * acceleration, delta * acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, delta * acceleration)
		
func move_to_player(delta):
	var player_pos = player_node.position
	var distance_to_player = position.distance_to(player_pos)
	
	if distance_to_player > player_node.threshold:
		var direction = position.direction_to(player_pos)
		velocity = velocity.lerp(direction * speed * acceleration, delta * acceleration)
	else:
		looking_for_player = false;
	
