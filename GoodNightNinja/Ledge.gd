extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var one_way_collision = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if one_way_collision:
		$NormalPlatform.one_way_collsion = true
	else:
		$NormalPlatform.one_way_collision = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
