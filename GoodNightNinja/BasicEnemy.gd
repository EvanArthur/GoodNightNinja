extends RigidBody2D

class_name BasicEnemy

# basic variables 
const WALK_SPEED = 50
const STATE_WALKING = 0
const STATE_DYING = 1
const STATE_ATTACKING = 2

# used to control basic state and direction of sprite/animation
var state = STATE_WALKING
var direction = -1
var animation = ""

var health = 1

onready var rc_left = $RayCastLeft
onready var rc_right = $RayCastRight

var star = preload("res://Player/NinjaStar.gd")
var player = preload("res://Player/Ninja.gd")

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
func _onHit(countact, s, dp):
	health = health - 0.25
	if health <=0:
		mode = MODE_RIGID
		state = STATE_DYING
		
		s.set_angular_velocity(sign(dp.x) * 33.0)
		set_friction(1)
		countact.disable()
	
func _integrate_forces(s):
	var linVel = s.get_linear_velocity()
	var new_animation = animation
	
	if state == STATE_DYING:
		#new_animation = "ded"
		pass
	elif state == STATE_WALKING:
		#new_animation = "welk"
		
		var wall_side = 0.0
		
		for i in range(s.get_contact_count()):
			var countact = s.get_contact_collider_object(i)
			var dp = s.get_contact_local_normal(i)
			
			if countact:
				if countact is star and not countact.disabled:
					call_deferred("_onHit", countact, s, dp)
					break
				if countact is player and not countact.disabled:
					state = STATE_ATTACKING
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
	elif state == STATE_ATTACKING:
		#new_animation = "attek"
		pass
		
	if animation != new_animation:
		animation = new_animation

		
	
			
	
	
	