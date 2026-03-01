extends Node2D

const CLOUD_SPEED = 100.0

func _physics_process(delta):
	position.x += CLOUD_SPEED * delta
