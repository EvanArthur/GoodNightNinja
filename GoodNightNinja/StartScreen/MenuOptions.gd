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
	print("Play Button Pressed")
	get_tree().change_scene("res://Levels/Level1.tscn")


func _on_SettingsButton_pressed():
	print("Settings Button Pressed")
	get_tree().change_scene("res://StartScreen/SettingsScreen/SettingsScreen.tscn")

func _on_ContinueButton_pressed():
	print("Continue Button Pressed")
	get_tree().change_scene("res://Levels/Level3Test.tscn")
