extends RigidBody2D

class_name Ninja
#Character Demo, written by Juan Linietsky.

# Member variables
const WALK_ACCEL = 2000.0
const WALK_DEACCEL = 1000.0
const WALK_MAX_VELOCITY = 700.0
const AIR_ACCEL = 25.0
const JUMP_VELOCITY = 750
const STOP_JUMP_FORCE = 900.0
const MAX_SHOOT_POSE_TIME = 0.3
const MAX_FLOOR_AIRBORNE_TIME = 0.15

var anim = ""
var siding_left = false
var jumping = false
var stopping_jump = false
var shooting = false
var star_count = 5
var floor_h_velocity = 0.0

var airborne_time = 1e20
var shoot_time = 1e20
var local_collision_pos

# health stuff here. Created by Will
signal health_updated
signal killed

export var max_health = 100
onready var health = max_health setget _set_health
onready var invulnerability_timer = $InvulnterabilityTimer

func damage(amount):
	if invulnerability_timer.is_stopped():
		invulnerability_timer.start()
		_set_health(health - amount)
		print("Ninja health: " + str(health))

func _die():
	queue_free()
	
func _preDie():
	$NinjaArea.queue_free()
	$IdleCollision.queue_free()
	_die()
	
#despawn character and go to respawn screen
func _kill():
	_preDie()
	get_tree().change_scene("res://StartScreen/RespawnScreen.tscn")

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health == 0:
			_kill()
			emit_signal("killed")

var NinjaStar = preload("res://player/NinjaStar.tscn")
#var Enemy = preload("res://enemy/Enemy.tscn")
		
func _shot_ninja_star():
	shoot_time = 0
	var bi = NinjaStar.instance()
	var ss
	if siding_left:
		ss = -2.0
	else:
		ss = 2.0
	var pos = position + ($NinjaStarShoot as Position2D).position * Vector2(ss, 1.0)

	bi.position = pos
	get_parent().add_child(bi)
	
	bi.linear_velocity = Vector2(800.0 * ss, -80)

	($Sprite/Smoke as Particles2D).restart()
	($SoundShoot as AudioStreamPlayer2D).play()
	add_collision_exception_with(bi)
	
func restore_ninja_stars():
	star_count = 5
	
func increment_ninja_stars():
	star_count += 1
	clamp(star_count, 0, 5)

func _integrate_forces(s):

	var lv = s.get_linear_velocity()
	var step = s.get_step()
	
	var new_anim = anim
	var new_siding_left = siding_left
	
	# Get the controls
	var move_left = Input.is_action_pressed("ui_left")
	var move_right = Input.is_action_pressed("ui_right")
	var jump = Input.is_action_pressed("ui_up")
	var shoot = Input.is_action_pressed("ui_select")
	var spawn = Input.is_action_pressed("spawn")
	
	if spawn:
#		var e = Enemy.instance()
		var p = position
		
		p.y = p.y - 100
#		e.position = p
		
#		get_parent().add_child(e)
	
	# Deapply prev floor velocity
	lv.x -= floor_h_velocity
	floor_h_velocity = 0.0
	
	# Find the floor (a contact with upwards facing collision normal)
	var found_floor = false
	var floor_index = -1
	
	for x in range(s.get_contact_count()):
		var ci = s.get_contact_local_normal(x)
		
		if ci.dot(Vector2(0, -1)) > 0.6:
			found_floor = true
			floor_index = x
	
	# A good idea when implementing characters of all kinds,
	# compensates for physics imprecision, as well as human reaction delay.

	if shoot and not shooting:
		if star_count != 0:
			star_count -= 1
			$Sprite.play("shooting")
			call_deferred("_shot_ninja_star")
		else:
			print(star_count)
	else:
		shoot_time += step
	
	if found_floor:
		airborne_time = 0.0
	else:
		airborne_time = 200 # Time it spent in the air
	
	var on_floor = airborne_time < MAX_FLOOR_AIRBORNE_TIME

	# Process jump
	if jumping:
		if lv.y > 0:
			# Set off the jumping flag if going down
			jumping = false
		elif not jump:
			stopping_jump = true
		if stopping_jump:
			lv.y += STOP_JUMP_FORCE * step
			
		# Check siding
		if lv.y < 0 and move_left:
			new_siding_left = true
		elif lv.y > 0 and move_right:
			new_siding_left = false
	
	if on_floor:
		# Process logic when character is on floor
		if move_left and not move_right:
			if lv.x > -WALK_MAX_VELOCITY:
				lv.x -= WALK_ACCEL * step
		elif move_right and not move_left:
			if lv.x < WALK_MAX_VELOCITY:
				lv.x += WALK_ACCEL * 2*step
		else:
			lv.x = 0
		
		# Check jump
		if not jumping and jump:
			lv.y = -JUMP_VELOCITY
			jumping = true
			stopping_jump = false
			($SoundJump as AudioStreamPlayer2D).play()
		
		# Check siding
		if lv.x < 0 and move_left:
			new_siding_left = true
		elif lv.x > 0 and move_right:
			new_siding_left = false
		if jumping:
			new_anim = "jumping"
		elif abs(lv.x) < 0.1:
			if shoot_time < MAX_SHOOT_POSE_TIME:
				new_anim = "idle_weapon"
			else:
				new_anim = "idle"
		else:
			if shoot_time < MAX_SHOOT_POSE_TIME:
				new_anim = "run_weapon"
			else:
				new_anim = "run"
	else:
		# Process logic when the character is in the air
		if move_left and not move_right:
			if lv.x > -WALK_MAX_VELOCITY:
				lv.x -= AIR_ACCEL
		elif move_right and not move_left:
			if lv.x < WALK_MAX_VELOCITY:
				lv.x += AIR_ACCEL
		else:
			lv.x = 0
		
		if lv.y < 0:
			if shoot_time < MAX_SHOOT_POSE_TIME:
				new_anim = "jumping_weapon"
			else:
				new_anim = "jumping"
		else:
			if shoot_time < MAX_SHOOT_POSE_TIME:
				new_anim = "falling_weapon"
			else:
				new_anim = "falling"
	
	# Update siding
	if new_siding_left != siding_left:
		if new_siding_left:
			$Sprite.flip_h = true
		else:
			$Sprite.flip_h = false
		
		siding_left = new_siding_left
	
	# Change animation
	if new_anim != anim:
		anim = new_anim
		$Sprite.play(anim)
	
	shooting = shoot
	

	
	# Apply floor velocity
	if found_floor:
		floor_h_velocity = s.get_contact_collider_velocity_at_position(floor_index).x
		lv.x += floor_h_velocity
	
	# Finally, apply gravity and set back the linear velocity
	lv += s.get_total_gravity() * step
	s.set_linear_velocity(lv)