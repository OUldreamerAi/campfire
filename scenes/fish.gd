extends Node2D

var speed = 200
var direction = Vector2.RIGHT

func _process(delta):
	position += direction * speed * delta
