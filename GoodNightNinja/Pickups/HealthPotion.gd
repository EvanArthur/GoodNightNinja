extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _die():
	queue_free()

func _preDie():
	$CollisionShape2D.queue_free()
	_die()
	
func _on_HealthPotion_body_entered(body):
	if body.get_name() == "Ninja":
		body.damage(-15)
		_preDie()
