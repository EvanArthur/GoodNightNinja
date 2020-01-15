extends RigidBody2D

class_name BasicEnemy

# basic variables 
const WALK_SPEED = 50
const STATE_WALKING = 0
const STATE_DYING = 1

# used to control basic state and direction of sprite/animation
var state = STATE_WALKING
var direction = -1
var anim = ""

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
	mode = MODE_RIGID
	state = STATE_DYING
	
func _integrate_forces(state):
	
	

