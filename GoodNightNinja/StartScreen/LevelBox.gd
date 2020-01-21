extends VBoxContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.level1:
		#get_node("Level1").visible = true
		$Level1.visible = true
	else:
		#get_node("Level1").visible = false
		$Level1.visible = false
	if Global.level2:
		#get_node("Level2").visible = true
		$Level2.visible = true
	else:
		#get_node("Level2").visible = false
		$Level2.visible = false
	if Global.level3:
		$Level3.visible = true
	else:
		$Level3.visible = false
	if Global.level4:
		$Level4.visible = true
	else:
		$Level4.visible = false
	if Global.level5:
		$Level5.visible = true
	else:
		$Level5.visible = false

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

func _on_Level3_pressed():
	print("Level 3 Button Pressed")
	get_tree().change_scene("res://Levels/Level3.tscn")

func _on_Level4_pressed():
	print("Level 3 Button Pressed")
	get_tree().change_scene("res://Levels/Level4.tscn")	
	
func _on_Level5_pressed():
	print("Level 3 Button Pressed")
	get_tree().change_scene("res://Levels/Level5.tscn")
