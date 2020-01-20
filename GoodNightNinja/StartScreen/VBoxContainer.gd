extends VBoxContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.level1:
		get_node("Level1").visible = true
	else:
		get_node("Level1").visible = false
	if Global.level2:
		get_node("Level2").visible = true
	else:
		get_node("Level2").visible = false
		
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ReturnButton_pressed():
	print("Return Button Pressed")
	get_tree().change_scene("res://StartScreen/MainMenu.tscn")


func _on_Level1_pressed():
	print("Level 1 Button Pressed")
	get_tree().change_scene("res://Levels/Level1.tscn")
	


func _on_Level2_pressed():
	print("Level 2 Button Pressed")
	get_tree().change_scene("res://Levels/Level2.tscn")
