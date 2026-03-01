extends Node2D

var speed = 200
var direction = Vector2.RIGHT

func _process(delta):
	if direction == Vector2.RIGHT:
		position += direction * speed * delta *2
	else:
		position += direction * speed * delta
