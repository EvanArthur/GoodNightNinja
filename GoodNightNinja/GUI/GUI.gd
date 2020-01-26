extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var health_bar = $HBoxContainer/Bars/Bar/HealthBar
onready var number_label = $HBoxContainer/Bars/Bar/Count/Background/Number


# Called when the node enters the scene tree for the first time.
func _ready():
	var max_player_health = 100 #figure out how to get it from player here
	health_bar.max_value = max_player_health
	#$"../Ninja".connect("health_updated", self, "_on_health_updated")
	
	

func _on_Ninja_health_updated(health):
	health_bar.value = health
	number_label.text = str(health)
	
func on_max_health_updated(max_health):
	health_bar.max_value = max_health
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass