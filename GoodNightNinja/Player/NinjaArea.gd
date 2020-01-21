extends Area2D

func _on_NinjaArea_body_entered(body):
	print(body.name)
	if body.name == "StaticBody2D":
		body.queue_free()