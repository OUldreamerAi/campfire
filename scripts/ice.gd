extends Node2D

@export var iceScene: PackedScene
@export var iceSceneAlt: PackedScene
@export var spikeScene: PackedScene

@export var floorY: = 360
@export var spikeFreq = 4
@export var spikeOffsetY = 75
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
		for i in randi_range(1,spikeFreq):
			var spike = spikeScene.instantiate()
			spike.position = Vector2(lastSpawnX, floorY + spikeOffsetY)
			add_child(spike)
	else:
		blockAlt.position = Vector2(lastSpawnX, floorY)
		add_child(blockAlt)
	lastSpawnX += blockWidth



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
		

func _on_area_to_add_floor_body_entered(body: Node2D) -> void:
	call_deferred("_expand_floor")

var consecutiveHoles = 0



func _expand_floor():
	expandFloorArea.position += Vector2(700, 0)



	for i in range(10):
		if randi_range(1, holeFreq) == 1 and consecutiveHoles < 4:
			lastSpawnX += blockWidth
			consecutiveHoles += 1
		else:
			spawnBlock()
			consecutiveHoles = 0
	
		
