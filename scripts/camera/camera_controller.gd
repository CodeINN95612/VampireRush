extends CharacterBody2D

@export var speed: float = 100
@export var acceleration: float = 10.0
@export var threshold_value: float = 50.0
@export var player_node: PlayerVampire

@onready var camera := $Camera2D;
@onready var threshold := player_node.threshold_stop

var move_zone_start: Vector2
var looking_for_player: bool

func _ready():
	looking_for_player = false
	
	warp_mouse_to_center()
	
	var size = get_viewport_rect().size;
	var end_x = size.x / camera.zoom.x * 0.5 - threshold_value;
	var end_y = size.y / camera.zoom.y * 0.5 - threshold_value;
	var start = Vector2(end_x, end_y)
	
	move_zone_start = start
	
func _input(event):
	if event.is_action_pressed("ui_select"):
		var player_pos = player_node.position
		var distance_to_player = position.distance_to(player_pos)
		if distance_to_player > threshold:
			looking_for_player = true
	
func _physics_process(delta):
	
	if looking_for_player:
		move_to_player(delta)
	else:
		move_to_mouse(delta)
	move_and_slide()
	

func move_to_mouse(delta):
	var mouse_pos = get_global_mouse_position() 
	var screen_center = camera.get_screen_center_position()
	var relative_mouse_pos = mouse_pos-screen_center;
	
	if(abs(relative_mouse_pos.x) >= move_zone_start.x or abs(relative_mouse_pos.y) >= move_zone_start.y):
		var direction = screen_center.direction_to(mouse_pos);
		velocity = velocity.lerp(direction * speed * acceleration, delta * acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, delta * acceleration * 2)
		
func move_to_player(delta):
	var player_pos = player_node.position
	var distance_to_player = position.distance_to(player_pos)
	
	if distance_to_player > 3:
		var direction = position.direction_to(player_pos)
		const min_factor = 0.0001
		const max_factor = 5
		var factor = clampf(map(distance_to_player, 0, 600, min_factor, max_factor), min_factor, max_factor)
		velocity = velocity.lerp(direction * speed * acceleration * factor, delta * acceleration)
	else:
		looking_for_player = false

func warp_mouse_to_center():
	get_viewport().warp_mouse(get_viewport().size / 2);

func map(value: float, start1: float, end1: float, start2: float, end2: float) -> float:
	return start2 + (end2 - start2) * ((value - start1) / (end1 - start1))
