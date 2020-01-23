extends Node2D

var time_start
var time_now
var str_elapsed

# Called when the node enters the scene tree for the first time.
func _ready():
	time_start = OS.get_unix_time()
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_now = OS.get_unix_time()
	var elapsed = time_now - time_start
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	str_elapsed = "%02d : %02d" % [minutes, seconds]	


func _on_LevelEnd_body_entered(body):
	print("You Finished Level "+str(Global.currentStage))
	#Global.currentStage += 1
	#if Global.currentStage == 2:
	#	Global.level2 = true
	#elif Global.currentStage == 3:
	#	Global.level3 = true
	#elif Global.currentStage == 4:
	#	Global.level4 = true
	#	Global.level5 == true
	# loads end screen and gives time elapsed
	get_tree().change_scene("res://StartScreen/EndScreen.tscn")
	#Global.timeElapsed = str_elapsed
	#get_node("EndScreen/EndContainer/LevelLabel").set_text(str_elapsed)
	#get_tree().get_root().get_node("/root/EndScreen/EndContainer/LevelLabel").set_text(str_elapsed)
	



func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	print("You Finished Level "+str(Global.currentStage))
	Global.currentStage += 1
	if Global.currentStage == 2:
		Global.level2 = true
	elif Global.currentStage == 3:
		Global.level3 = true
	elif Global.currentStage == 4:
		Global.level4 = true
	elif Global.currentStage == 5:
		Global.level5 == true
	# loads end screen and gives time elapsed
	get_tree().change_scene("res://StartScreen/EndScreen.tscn")
	Global.timeElapsed = str_elapsed
	#get_node("EndScreen/EndContainer/LevelLabel").set_text(str_elapsed)
	#get_tree().get_root().get_node("/root/EndScreen/EndContainer/LevelLabel").set_text(str_elapsed)
	
