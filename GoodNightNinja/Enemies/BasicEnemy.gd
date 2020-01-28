extends RigidBody2D

class_name BasicEnemy

# basic variables 
var WALK_SPEED = 50
const STATE_WALKING = 0
const STATE_DYING = 1
const STATE_ATTACKING = 2

# used to control basic state and direction of sprite/animation
var state = STATE_WALKING
var direction = 1
var animation = ""
var new_animation = ""

var health = 100
var object = []
var other = []

onready var rc_left = $RayCastLeft
onready var rc_right = $RayCastRight
onready var weak_point = $WeakPoint
onready var forAtt=$AttackZoneF
onready var backAtt=$AttackZoneB

var star = preload("res://Player/NinjaStar.gd")
var player = preload("res://Player/Ninja.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _die():
	queue_free()

func _preDie():
	$AnimatedSprite.play("ded")
	mode = MODE_STATIC
	rc_left.queue_free()
	rc_right.queue_free()
	weak_point.queue_free()
	$CollisionShape2D.queue_free()
	yield(get_tree().create_timer(1.2), "timeout")
	$EnemyHitbox.queue_free()
	call_deferred("_die")
	
	#play sound or death animation here
	
# called after hit with melee or ranged attack
func _onHit():
	health = health - 50
	if health == 0:
		state = STATE_DYING
		set_friction(1000)
		_preDie()

	
func _integrate_forces(s):
	
	if state == STATE_DYING:
		return
		
	$RayCastLeft.add_exception($DamageZone)
	$RayCastRight.add_exception($DamageZone)
	$StrongPoint.add_exception($DamageZone)
	$WeakPoint.add_exception($DamageZone)
	$AttackZoneB.add_exception($DamageZone)
	$AttackZoneF.add_exception($DamageZone)
	
	
	$RayCastLeft.add_exception($DamageZone2)
	$RayCastRight.add_exception($DamageZone2)
	$StrongPoint.add_exception($DamageZone2)
	$WeakPoint.add_exception($DamageZone2)
	$AttackZoneB.add_exception($DamageZone2)
	$AttackZoneF.add_exception($DamageZone2)
	var linVel = s.get_linear_velocity()
	new_animation = animation

	if state == STATE_WALKING:
		if direction >0:
			forAtt.set_enabled(true)
			backAtt.set_enabled(false)
		else:
			backAtt.set_enabled(true)
			forAtt.set_enabled(false)
		WALK_SPEED=100
		new_animation = "welk"
		#$DamageZone/Collide.set_disabled(true)
		
		if rc_right.is_colliding()==false and direction>0:
			direction = -direction
			$AnimatedSprite.flip_h=true
			weak_point.position.x*=-1
			$StrongPoint.position.x*=-1
			$DamageZone.position.x*=-1
			
			
			#strong.position.x*=-1
		elif rc_left.is_colliding()==false and direction<0:
			direction = -direction
			$AnimatedSprite.flip_h=false
			weak_point.position.x*=-1
			$StrongPoint.position.x*=-1
		
		if $StrongPoint.is_colliding():
			if $StrongPoint.get_collider().name =="Ninja":
				state=STATE_ATTACKING
			else:
				direction = -direction
				if $StrongPoint.position.x>0:
					$AnimatedSprite.flip_h=true
				else:
					$AnimatedSprite.flip_h=false
				weak_point.position.x*=-1
				$StrongPoint.position.x*=-1
				print($StrongPoint.get_collider().name)

		if weak_point.is_colliding() and object.find(weak_point.get_collider())==-1:
			if weak_point.get_collider().name=="NinjaStar":
				call_deferred("_onHit")
			object.append(weak_point.get_collider())
			
#		if direction<0:
#			var zone = $DamageZone.get_overlapping_bodies()
#			if not zone.empty():
#				var body = zone.front()
#				#print(body,get_name())
#				if body.get_name() == "NinjaStar":
#					call_deferred("_onHit")
#		else:
#			var zone = $DamageZone2.get_overlapping_bodies()
#			if not zone.empty():
#				var body = zone.front()
#				#print(body,get_name())
#				if body.get_name() == "NinjaStar":
#					call_deferred("_onHit")
		if forAtt.is_colliding():
			if forAtt.get_collider().name=="Ninja":
				state=STATE_ATTACKING
		if backAtt.is_colliding():
			if backAtt.get_collider().name=="Ninja":
				state=STATE_ATTACKING
		linear_velocity.x = direction * WALK_SPEED
		
	elif state == STATE_ATTACKING:
		#$DamageZone/Collide.set_disabled(false)
		if direction>0:
			var zone = $DamageZone.get_overlapping_bodies()
			if not zone.empty():
				var body = zone.front()
				if body.get_name() == "Ninja":
					if $Timer.is_stopped():
						$Timer.start()
						body.damage(30)
		else:
			var zone = $DamageZone2.get_overlapping_bodies()
			if not zone.empty():
				var body = zone.front()
				if body.get_name() == "Ninja":
					if $Timer.is_stopped():
						$Timer.start()
						body.damage(30)

		
		if $EnragedTimer.is_stopped():
			state=STATE_WALKING
		if $EnragedTimer.is_stopped():
			$EnragedTimer.start()
		new_animation="attak"
		if backAtt.is_enabled()==false:
			backAtt.set_enabled(true)
		else:
			forAtt.set_enabled(true)
		WALK_SPEED=200
		if forAtt.is_colliding():
			if forAtt.get_collider().name=="Ninja" and direction==-1:
				direction=-direction
				$AnimatedSprite.flip_h=false
				weak_point.position.x*=-1
				$StrongPoint.position.x*+-1
				$EnragedTimer.start()
		if backAtt.is_colliding():
			if backAtt.get_collider().name=="Ninja" and direction==1:
				direction=-direction
				$AnimatedSprite.flip_h=true
				weak_point.position.x*=-1
				$StrongPoint.position.x*+-1
				$EnragedTimer.start()
		if rc_right.is_colliding()==false and direction>0:
			direction = -direction
			$AnimatedSprite.flip_h=true
			weak_point.position.x*=-1
			$StrongPoint.position.x*+-1

		elif rc_left.is_colliding()==false and direction<0:
			direction = -direction
			$AnimatedSprite.flip_h=false
			weak_point.position.x*=-1
			$StrongPoint.position.x*+-1

		linear_velocity.x = direction * WALK_SPEED
		
	if animation != new_animation:
		animation = new_animation
		$AnimatedSprite.play(animation)

func _on_AnimatedSprite_animation_finished():
	return true
	


func _on_DamageZone_body_entered(body):
	if body.get_name() == "NinjaStar":
		_onHit()


func _on_DamageZone2_body_entered(body):
	pass
#	if body.get_name() == "NinjaStar":
#		_onHit()
