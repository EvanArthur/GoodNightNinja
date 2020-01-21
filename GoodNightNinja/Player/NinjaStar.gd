extends RigidBody2D

class_name NinjaStar

# Member variables
var disabled = false

func _ready():
	add_collision_exception_with(self)
	($Timer as Timer).start()

func disable():
	if disabled:
		return
	
	($Anim as AnimationPlayer).play("shutdown")
	disabled = true