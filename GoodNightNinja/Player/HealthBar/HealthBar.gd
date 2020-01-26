extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var health_bar = $HealthBar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_health_updated(health, amount):
	health_bar.value = health
	
func on_max_health_updated(max_health):
	health_bar.max_value = max_health
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
