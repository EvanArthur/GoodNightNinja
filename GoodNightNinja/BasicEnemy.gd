extends RigidBody2D

class_name BasicEnemy

# basic variables 
const WALK_SPEED = 50
const STATE_WALKING = 0
const STATE_DYING = 1
const STATE_ATTACKING = 2

# used to control basic state and direction of sprite/animation
var state = STATE_WALKING
var direction = 1
var animation = ""

var health = 1
var object = null

onready var rc_left = $RayCastLeft
onready var rc_right = $RayCastRight
onready var weak_point = $WeakPoint

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
func _onHit():
	health = health - 0.25
	print(health)
	if health <=0:
		state = STATE_DYING
		
		set_friction(1000)

	
func _integrate_forces(s):
	var linVel = s.get_linear_velocity()
	var new_animation = animation
	
	if state == STATE_DYING:
		new_animation = "ded"
		call_deferred("_die")
		
	elif state == STATE_WALKING:
		new_animation = "welk"
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
		if rc_right.is_colliding()==false and direction>0:
			direction = -direction
			$AnimatedSprite.flip_h=true
			weak_point.position.x*=-1
		elif rc_left.is_colliding()==false and direction<0:
			direction = -direction
			$AnimatedSprite.flip_h=false
			weak_point.position.x*=-1

		if weak_point.is_colliding() and weak_point.get_collider()!=object:

			call_deferred("_onHit")
			object = weak_point.get_collider()
		
		linear_velocity.x = direction * WALK_SPEED
		
	elif state == STATE_ATTACKING:
		#new_animation = "attek"
		pass
		
	if animation != new_animation:
		animation = new_animation
		$AnimatedSprite.play(animation)