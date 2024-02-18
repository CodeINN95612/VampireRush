extends CharacterBody2D
class_name PlayerVampire

#directions
const UP := Rect2(0, 0, 16, 16);
const UP_RIGHT := Rect2(16, 0, 16, 16);
const RIGHT := Rect2(32, 0, 16, 16);
const DOWN_RIGHT := Rect2(48, 0, 16, 16);
const DOWN := Rect2(64, 0, 16, 16);
const DOWN_LEFT := Rect2(80, 0, 16, 16);
const LEFT := Rect2(96, 0, 16, 16);
const UP_LEFT := Rect2(112, 0, 16, 16);

@export var speed = 100
@export var acceleration = 5;
@export var threshold: float = 35;

var tile_atlas: Sprite2D;
var direction := Vector2.ZERO;

func _ready():
	tile_atlas = $Sprite2D;

func _physics_process(delta):
	player_move(delta)
	player_animate()

func player_move(delta):
	var mouse_pos = get_global_mouse_position()
	direction = (mouse_pos - position).normalized()
	
	if position.distance_to(mouse_pos) > threshold:
		velocity = velocity.lerp(direction * speed * acceleration, delta * acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, delta * acceleration)
	
	move_and_slide()

func player_animate():
	tile_atlas.region_enabled = true;
	var region_rect := DOWN;
	
	if direction.y >= 0: #DOWN
		if direction.x < -0.75:
			region_rect = LEFT;
		elif direction.x < -0.25:
			region_rect = DOWN_LEFT;
		elif direction.x < 0.25:
			region_rect = DOWN;
		elif direction.x < 0.75:
			region_rect = DOWN_RIGHT;
		else:
			region_rect = RIGHT;
	else: #UPN
		if direction.x < -0.75:
			region_rect = LEFT;
		elif direction.x < -0.25:
			region_rect = UP_LEFT;
		elif direction.x < 0.25:
			region_rect = UP;
		elif direction.x < 0.75:
			region_rect = UP_RIGHT;
		else:
			region_rect = RIGHT;
			
	tile_atlas.region_rect = region_rect
