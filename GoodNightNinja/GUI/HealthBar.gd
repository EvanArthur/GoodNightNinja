extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var health_bar = $HealthBar
onready var number_label = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	var max_player_health = $"..../Player/Ninja".max_health
	
	

func _on_health_updated(health, amount):
	health_bar.value = health
	
func on_max_health_updated(max_health):
	health_bar.max_value = max_health
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
