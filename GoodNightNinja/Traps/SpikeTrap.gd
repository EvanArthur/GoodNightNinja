extends Node2D

class_name SpikeTrap

onready var timer = $SpikeTrap/Timer

export var motion = Vector2()
export var cycle = 1.0

var accum = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = $SpikeTrap/BottomPlatform/Spikes.get_overlapping_bodies()
	if not bodies.empty():
		var body = bodies.front()
		if body.get_name() == "Ninja":
			if timer.is_stopped():
				timer.start()
				body.damage(30)


func _physics_process(delta):
	accum += delta * (1.0 / cycle) * PI * 2.0
	accum = fmod(accum, PI * 2.0)
	
	var d = sin(accum)
	var xf = Transform2D()
	
	xf[2]= motion * d 
	($SpikeTrap as RigidBody2D).transform = xf


func _on_Spikes_body_entered(body):
	if body.get_name() == "Ninja":
		pass
	#	body.damage(30)
