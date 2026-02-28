extends Node

signal jump_triggered
var input_direction: float = 0.0
var should_jump: bool = false

func _process(_delta: float) -> void:
	input_direction = Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_just_pressed("ui_accept"):
		should_jump = true
		jump_triggered.emit()
	else:
		should_jump = false
