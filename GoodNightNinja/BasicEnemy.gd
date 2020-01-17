extends RigidBody2D

class_name BasicEnemy

# basic variables 
const WALK_SPEED = 50
const STATE_WALKING = 0
const STATE_DYING = 1

# used to control basic state and direction of sprite/animation
var state = STATE_WALKING
var direction = -1
var animation = ""

var health = 1

onready var rc_left = $RaycastLeft
onready var rc_right = $RaycastRight

var star = preload("res://Player/NinjaStar.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _die():
	queue_free()

func _preDie():
	$EnemyHitbox.queue_free()
	#property of RigidBody. Makes it stay in place
	mode = MODE_STATIC
	
	#play sound or death animation here
	
# called after hit with melee or ranged attack
func _onHit(countact, state, dp):
	health = health - 0.25
	if health <=0:
		mode = MODE_RIGID
		state = STATE_DYING
		
		state.set_angular
	
func _integrate_forces(state):
	var linVel = state.get_linear_velocity()
	var new_animation = animation
	
	if state == STATE_DYING:
		new_animation = "ded"
	elif state == STATE_WALKING:
		new_animation = "welk"
		
		var wall_side = 0.0
		
		for i in range(state.get_contact_count()):
			var countact = state.get_contact_collider_object(i)
			var dp = state.get_contact_local_normal(i)
			
			if countact:
				if countact is star and not countact.disabled:
					call_deferred("_onHit", countact, state, dp)
					break
			if dp.x > 0.9:
				wall_side=1.0
			elif dp.x < -0.9:
				wall_side = -1.0
		if wall_side !=0 and wall_side != direction:
			direction = - direction
			($Sprite as Sprite).scale.x = -direction
		if direction < 0 and not rc_left.is_colliding() and rc_right.is_colliding():
			direction = -direction
			($Sprite as Sprite).scale.x = -direction
		elif direction > 0 and not rc_right.is_colliding() and rc_left.is_colliding():
			direction = -direction
			($Sprite as Sprite).scale.x = -direction
		
		linear_velocity.x = direction * WALK_SPEED
		
	if animation != new_animation:
		animation = new_animation

		
	
			
	
	
	