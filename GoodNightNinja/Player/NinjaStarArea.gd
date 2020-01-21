extends Area2D

func _on_NinjaStarArea_body_entered(body):
	if body.name == 'Ninja' or body.name == '@Ninja@1' or body.name == '@Ninja@2' or body.name == '@Ninja@3' or body.name == '@Ninja@4' or body.name == '@Ninja@5' or body.name == '@Ninja@6':
		body.incriment_ninja_stars()
		print(body.name)