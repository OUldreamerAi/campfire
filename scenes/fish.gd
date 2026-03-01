extends Node2D

var speed = 200
var direction = Vector2.RIGHT
var alive = true


func _process(delta):
	if !alive:
		scale *= 0.9
		if abs(scale.x) < 0.05:
			queue_free()
	if direction == Vector2.RIGHT:
		position += direction * speed * delta *2
	else:
		position += direction * speed * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	alive = false
