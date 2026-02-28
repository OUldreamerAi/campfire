extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var playerUp: CharacterBody2D

func _ready() -> void:
	playerUp= $"../PlayerUp"
	

func _process(delta: float) -> void:
	position.x = playerUp.position.x 
	position.y = -playerUp.position.y + 200
	
	

	move_and_slide()
