extends Area2D

func _on_Area2D_body_entered(body):
	if body.name=='NinjaStar':
		body.queue_free()
		print(get_children())