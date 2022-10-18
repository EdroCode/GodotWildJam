extends KinematicBody2D
class_name Enemy

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

enum {
	IDLE,
	WANDER,
	CHASE,
	ATTACK
}

var velocity = Vector2.ZERO
var state = IDLE
var attacking = false

onready var wanderController = $WanderController
onready var playerDetectionZone = $PlayerDetectionZone

func _ready():
	state = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
		WANDER:
			seek_player()
			accelerate_towards_point(wanderController.target_position, delta)
			print('wandering')
			if wanderController.get_time_left() == 0:
				update_wander()
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
		CHASE:
			var player = playerDetectionZone.player
			if attacking:
				state = ATTACK
			if !(player == null):
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE
		ATTACK:
			attack_state()
	
	velocity = move_and_slide(velocity)

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(1)

func attack_state():
	pass

func _on_AttackZone_body_entered(body):
	if body.name == 'Player':
		attacking = true

func _on_AttackZone_body_exited(body):
	if body.name == 'Player':
		attacking = false
	state = pick_random_state([IDLE, WANDER])
