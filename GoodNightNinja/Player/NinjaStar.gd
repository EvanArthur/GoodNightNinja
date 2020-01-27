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
	queue_free()

func _on_StarArea_body_entered(body):
	if body.name == "Ninja":
		body.increment_ninja_stars()
		disable()
	if body.name == "BasicEnemy":
		print("Found basic enemy")
		body._onHit()
		disable()
	
