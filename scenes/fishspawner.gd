extends Node2D

# Загружаем сцену рыбы
@export var fish_scene: PackedScene

# Пределы спавна по Y
@export var min_y: float = 350
@export var max_y: float = 700

# Интервал спавна
@export var spawn_interval: float = 2.0
var spawn_timer = 0.0

func _process(delta):
	spawn_timer -= delta
	if spawn_timer <= 0:
		spawn_fish()
		spawn_timer = spawn_interval

func spawn_fish():
	var fish = fish_scene.instantiate()
	# Определяем направление случайно
	if randi() % 2 == 0:
		# Спавн слева -> плывёт вправо
		fish.position = Vector2(-50, randf_range(min_y, max_y))
		fish.direction = Vector2.RIGHT
		fish.scale.x = 1  # текстура не отражена
	else:
		# Спавн справа -> плывёт влево
		fish.position = Vector2(get_viewport().size.x + 50, randf_range(min_y, max_y))
		fish.direction = Vector2.LEFT
		fish.scale.x = -1  # отражаем текстуру по X

	add_child(fish)
