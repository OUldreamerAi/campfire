extends Node2D

const Cloud = preload("res://scenes/cloud.tscn")
const CLOUD_SPAWN_RATE = 1.0
const PLAYER_SPEED = 170.0
const PARALLAX_FACTOR = -0.7  # Clouds move at 30% of player speed (creates depth illusion)

var spawn_timer = 0.0
var player_velocity = 0.0

func _ready() -> void:
	# Spawn a few clouds to start at the top
	for i in range(3):
		spawn_cloud_at(-200)

func _physics_process(delta: float) -> void:
	spawn_timer += delta
	
	# Spawn new cloud from left at top
	if spawn_timer >= CLOUD_SPAWN_RATE:
		spawn_cloud_at(-200)
		spawn_timer = 0.0
	
	# Get player movement direction
	var direction := Input.get_axis("ui_left", "ui_right")
	
	# Move player
	if direction:
		position.x += direction * PLAYER_SPEED * delta
		player_velocity = direction * PLAYER_SPEED
	else:
		player_velocity = 0.0
	
	# Move all clouds slower than player (parallax effect)
	# This makes them appear distant/far away
	for child in get_children():
		child.position.x += player_velocity * PARALLAX_FACTOR * delta
		

func spawn_cloud_at(x: float) -> void:
	var cloud = Cloud.instantiate()
	cloud.position.x = x
	cloud.position.y = randf_range(0, 200)  # Only spawn at top of screen
	cloud.scale = Vector2.ONE * randf_range(2.5, 5.0)
	add_child(cloud)
