extends Sprite2D


var falling := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if falling:
		position += Vector2(0,100) * delta


func _on_area_2d_body_entered(body):
	await get_tree().create_timer(5).timeout
	await shake(2.0)
	falling = true


func shake(duration: float):
	var timer = 0.0
	var original_pos = position
	
	while timer < duration:
		position = original_pos + Vector2(
			randf_range(-2, 2),
			randf_range(-2, 2)
		)
		
		await get_tree().create_timer(0.01).timeout
		timer += 0.01
	
	position = original_pos
