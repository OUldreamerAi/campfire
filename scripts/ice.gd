extends Node2D

@export var iceScene: PackedScene
@export var iceSceneAlt: PackedScene
@export var floorY: = 360
@export var startBlocks = 30
@export var holeFreq: = 5

var lastSpawnX: int =  35
var blockWidth = 70
@export var expandFloorArea: Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	for i in range(startBlocks):
		call_deferred("spawnBlock")
	
func spawnBlock():
	var block = iceScene.instantiate()
	var blockAlt = iceSceneAlt.instantiate()
	
	if randi_range(0, 1) == 1:
		block.position = Vector2(lastSpawnX, floorY)
		add_child(block)
	else:
		blockAlt.position = Vector2(lastSpawnX, floorY)
		add_child(blockAlt)
	lastSpawnX += blockWidth



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		

func _on_area_to_add_floor_body_entered(body: Node2D) -> void:
	call_deferred("_expand_floor")

func _expand_floor():
	expandFloorArea.position += Vector2(700, 0)

	var hole_remaining = 0

	for i in range(10):

		if hole_remaining > 0:
			lastSpawnX += blockWidth
			hole_remaining -= 1
			continue

		if randi_range(1, holeFreq) == holeFreq:
			hole_remaining = randi_range(1, 2)
			lastSpawnX += blockWidth
			hole_remaining -= 1
			continue

		spawnBlock()
	
		
