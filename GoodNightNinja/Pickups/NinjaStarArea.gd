extends Area2D

func _on_NinjaStarArea_body_entered(body):
	if body.name == "Ninja":
		body.restore_ninja_stars()