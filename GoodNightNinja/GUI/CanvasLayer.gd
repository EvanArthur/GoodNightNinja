extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Ninja_health_updated(health):
	$GUI._on_Ninja_health_updated(health)
	
func on_max_health_updated(max_health):
	$GUI.on_max_health_updated(max_health)