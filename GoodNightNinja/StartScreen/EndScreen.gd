extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_ReturnButton_pressed():
	get_tree().change_scene("res://StartScreen/MainMenu.tscn")



func _on_RespawnButton_pressed():
	#get_tree().change_scene("res://Levels/Level"+str(Global.current_stage)+".tscn")
	get_tree().change_scene("res://Levels/LevelTemplate.tscn")
	
