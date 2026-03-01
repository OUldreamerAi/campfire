extends Node2D
@export var spawn_offset_x: float = 600
@export var fish_scene: PackedScene
@export var min_y: float = 400
@export var max_y: float = 450
@export var player:  CharacterBody2D

# Random spawn interval range
@export var min_spawn_interval: float = 2.0
@export var max_spawn_interval: float = 3.0
var spawn_timer = 0.0

func _ready():
	reset_spawn_timer()  # initialize first spawn

func _process(delta):
	spawn_timer -= delta
	if spawn_timer <= 0:
		spawn_fish()
		reset_spawn_timer()  # set a new random interval

func reset_spawn_timer():
	# Set a new random spawn interval
	spawn_timer = randf_range(min_spawn_interval, max_spawn_interval)

func spawn_fish():
	var fish = fish_scene.instantiate()
	var y = randf_range(min_y, max_y)
	var spawn_x: float

	# Decide which side to spawn on
	if randi() % 2 == 0:
		# Spawn on the left
		spawn_x = player.position.x - spawn_offset_x
		fish.direction = Vector2.RIGHT
		fish.scale.x = 1
	else:
		# Spawn on the right
		spawn_x = player.position.x + spawn_offset_x
		fish.direction = Vector2.LEFT
		fish.scale.x = -1

	# Make sure the fish doesn't spawn directly on the screen
	var screen_left = get_viewport().get_camera_2d().global_position.x - get_viewport_rect().size.x / 2
	var screen_right = get_viewport().get_camera_2d().global_position.x + get_viewport_rect().size.x / 2

	if spawn_x > screen_left and spawn_x < screen_right:
		if fish.direction.x > 0:
			spawn_x = screen_left   # A bit off the left side of the screen
		else:
			spawn_x = screen_right + 50  # A bit off the right side of the screen

	fish.position = Vector2(spawn_x, y)
	add_child(fish)
	fish.get_node("AnimatedSprite2D").play("swim")
