extends Node2D

var spikeDrop = false
@export var spikeSpeed = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spikeDrop:
		position += Vector2(0, 1)* spikeSpeed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	spikeDrop = true
	
