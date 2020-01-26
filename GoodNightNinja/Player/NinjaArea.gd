extends Area2D

func _on_NinjaArea_body_entered(body):
	print(body.name)
	if "StarPickup" in body.name:
		body.queue_free()