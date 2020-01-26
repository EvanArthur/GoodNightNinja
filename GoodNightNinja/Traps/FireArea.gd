extends Area2D

onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = get_overlapping_bodies()
	if not bodies.empty():
		var body = bodies.front()
		if body.get_name() == "Ninja":
			if timer.is_stopped():
				timer.start()
				body.damage(3)

