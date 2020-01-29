extends Node2D

export var visible_outside = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if visible_outside:
		$Outside.visible = true
	else:
		$Outside.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Entrance_body_entered(body):
	if body.get_name() == "Ninja":
		if $Outside.visible:
			$Outside.visible = false
		else:
			$Outside.visible = true


func _on_Exit_body_entered(body):
	if body.get_name() == "Ninja":
		if $Outside.visible:
			$Outside.visible = false
		else:
			$Outside.visible = true
