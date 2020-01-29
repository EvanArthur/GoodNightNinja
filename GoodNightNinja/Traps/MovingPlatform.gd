extends Node2D

class_name MovingPlatform

# Member variables
export var motion = Vector2()
export var cycle = 1.0
export var one_way_collision = false

var accum = 0.0

func _ready():
	if one_way_collision:
		$Platform/CollisionShape2D.one_way_collision = true
	else:
		$Platform/CollisionShape2D.one_way_collision = false


func _physics_process(delta):
	accum += delta * (1.0 / cycle) * PI * 2.0
	accum = fmod(accum, PI * 2.0)
	
	var d = sin(accum)
	var xf = Transform2D()
	
	xf[2]= motion * d 
	($Platform as RigidBody2D).transform = xf
