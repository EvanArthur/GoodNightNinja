extends Area2D

func _on_Area2D_body_entered(body):
	if 'NinjaStar' in body.name:
		body.get_parent().remove_child(body)