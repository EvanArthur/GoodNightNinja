extends VBoxContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Levels/Level1.tscn")
	#if Global.currentStage > Global.maxStage:
	#	get_tree().change_scene("res://Levels/Level"+str(Global.maxStage)+".tscn")

func _on_TutorialButton_pressed():
	get_tree().change_scene("res://StartScreen/TutorialScreen.tscn")

func _on_ContinueButton_pressed():
	get_tree().change_scene("res://StartScreen/LevelsScreen.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
