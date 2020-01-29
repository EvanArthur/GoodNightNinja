extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var full_collide = true
export var top_building_collide = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if full_collide:
		$StaticBody2D/CollisionShape2D.set_disabled(false)
	else:
		$StaticBody2D/CollisionShape2D.set_disabled(true)
	if top_building_collide:
		$TopBuildling/CollisionShape2D.set_disabled(false)
	else:
		$TopBuildling/CollisionShape2D.set_disabled(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
