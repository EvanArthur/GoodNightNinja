extends Area2D

func _on_NinjaArea_body_entered(body):
	print(body.name)
	if body.name == "StarPickup":
		body.queue_free()