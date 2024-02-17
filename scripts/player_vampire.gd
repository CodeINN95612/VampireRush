extends CharacterBody2D

#exports
@export var min_speed: float = 100.0;
@export var max_speed: float = 200.0;
@export var acceleration: float = 1.0;
@export var min_distance: float = 10.0;
@export var zoom_strength: float = 0.2;

#directions
const UP := Rect2(0, 0, 16, 16);
const UP_RIGHT := Rect2(16, 0, 16, 16);
const RIGHT := Rect2(32, 0, 16, 16);
const DOWN_RIGHT := Rect2(48, 0, 16, 16);
const DOWN := Rect2(64, 0, 16, 16);
const DOWN_LEFT := Rect2(80, 0, 16, 16);
const LEFT := Rect2(96, 0, 16, 16);
const UP_LEFT := Rect2(112, 0, 16, 16);

var current_dir := Vector2.ZERO;
var last_dir := Vector2.ZERO;

var tile_atlas: Sprite2D;

func _ready():
	tile_atlas = $Sprite2D;

func _physics_process(delta):
	player_movement(delta);
	player_animate();

func player_movement(delta):
	var mouse_pos = get_global_mouse_position();
	var direction = (mouse_pos - global_position).normalized()
	velocity = direction * min_speed;
	last_dir = direction;
	move_and_slide();
	
func player_animate():
	tile_atlas.region_enabled = true;
	var region_rect := DOWN;
	
	if last_dir.y >= 0: #DOWN
		if last_dir.x < -0.75:
			region_rect = LEFT;
		elif last_dir.x < -0.25:
			region_rect = DOWN_LEFT;
		elif last_dir.x < 0.25:
			region_rect = DOWN;
		elif last_dir.x < 0.75:
			region_rect = DOWN_RIGHT;
		else:
			region_rect = RIGHT;
	else: #UPN
		if last_dir.x < -0.75:
			region_rect = LEFT;
		elif last_dir.x < -0.25:
			region_rect = UP_LEFT;
		elif last_dir.x < 0.25:
			region_rect = UP;
		elif last_dir.x < 0.75:
			region_rect = UP_RIGHT;
		else:
			region_rect = RIGHT;
			
	tile_atlas.region_rect = region_rect
