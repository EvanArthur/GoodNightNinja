extends Node2D

export var full_collide = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	if full_collide:
		$StaticBody2D/CollisionShape2D.set_disabled(false)
	else:
		$StaticBody2D/CollisionShape2D.set_disabled(true)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
