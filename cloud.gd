extends Node2D

var speed = 100.0

func _physics_process(delta: float) -> void:
	position.x += speed * delta
