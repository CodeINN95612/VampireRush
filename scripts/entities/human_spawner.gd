extends Node2D

@export var enemyScene: PackedScene
@export var spawn_area_top_start: Node2D
@export var spawn_area_bottom_end: Node2D
@export var maxEnemies: int = 5

var enemies: Array = []

func _ready():
	spawnEnemies()

func spawnEnemies():
	var spawned := 0
	while spawned < maxEnemies:
		var spawnPosition = Vector2(
            randf_range(spawn_area_top_start.position.x, spawn_area_bottom_end.position.x),
            randf_range(spawn_area_top_start.position.y, spawn_area_bottom_end.position.y)
        )
		
		if isPositionValid(spawnPosition):
			var enemyInstance = enemyScene.instantiate()
			enemyInstance.position = spawnPosition
			add_child(enemyInstance)
			enemies.append(enemyInstance)
			spawned += 1

func isPositionValid(_position: Vector2) -> bool:
	return true
