extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ReturnButton_pressed():
	get_tree().change_scene("res://StartScreen/MainMenu.tscn")


func _on_ContinueButton_pressed():
	if Global.currentStage > Global.maxStage:
		print("You beat the game!")
		get_tree().change_scene("res://StartScreen/MainMenu.tscn")
	else:
		get_tree().change_scene("res://Levels/Level"+str(Global.currentStage)+".tscn")