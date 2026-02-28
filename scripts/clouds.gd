extends Node2D

const Cloud = preload("res://scenes/cloud.tscn")
const CLOUD_SPAWN_RATE = 2.0
const CLOUD_SPEED = 100.0
const SPEED = 170.0

var spawn_timer = 0.0

func _ready() -> void:
	for i in range(3):
		spawn_cloud(randf_range(0, 1920))

func _physics_process(delta: float) -> void:
	spawn_timer += delta
	
	if spawn_timer >= CLOUD_SPAWN_RATE:
		spawn_cloud(0)
		spawn_timer = 0.0
	
	# Move the entire scene (players and clouds together)
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		position.x += direction * SPEED * delta  # Fixed: += not =, and multiply by delta
	
	# Move clouds independently at their own speed
	for child in get_children():
		child.position.x += CLOUD_SPEED * delta  # Clouds drift on their own
		
		if child.position.x > get_viewport_rect().size.x + 900:
			child.queue_free()

func spawn_cloud(x_pos: float) -> void:
	var cloud = Cloud.instantiate()
	cloud.position.x = x_pos
	cloud.position.y = randf_range(50, 200)
	cloud.scale = Vector2.ONE * randf_range(3, 6)
	add_child(cloud)
