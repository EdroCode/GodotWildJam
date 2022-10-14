extends KinematicBody2D


enum STATES {IDLE, PATROL, ATTACK, DEAD}

var state_cur : int
var state_nxt : int

var anim_cur = ""
var anim_nxt = "Patrol"

var velocity = Vector2.ZERO
var turnAround : bool = false

var playerIsInArea : bool = false

var isDead : bool = false



var health : int = 10


onready var anim = $AnimationPlayer
onready var patrolTimer = $PatrolTimer
onready var hurtBox = $HurtBox
onready var playerDetect = $PlayerDetect


func _ready():
	
	patrolTimer.start()
	state_cur = -1
	state_nxt = STATES.PATROL


func _physics_process(delta):
	
	
	if state_cur != state_nxt:
		state_cur = state_nxt
	
	if anim_cur != anim_nxt:
		anim_cur = anim_nxt
		anim.play(anim_cur)
	
	
	match state_cur:
		
		STATES.IDLE:
			_state_idle(delta)
		STATES.PATROL:
			_state_patrol(delta)
		STATES.ATTACK:
			_state_attack(delta)
		STATES.DEAD:
			_state_dead(delta)
	
	
	
	
	if health <= 0:
		
		$CollisionShape2D.disabled = true
		_initialize_dead()
	
	



func _initialize_idle():
	
	state_nxt = STATES.IDLE
	anim_nxt = "Idle"
	velocity *= 0


func _state_idle(delta):
	
	move_and_slide(velocity, Vector2.UP)
	velocity. y += 500 * delta


func _initialize_patrol():
	
	state_nxt = STATES.PATROL
	anim_nxt = "Patrol"



func _state_patrol(delta):
	
	move_and_slide(velocity, Vector2.UP)
	velocity. y += 500 * delta
	
	
	
	if turnAround == true:
		$Rotate.scale.x = -1
		velocity.x = 45
		$Sprite.flip_h = true
	elif turnAround == false:
		$Rotate.scale.x = 1
		velocity.x = -45
		$Sprite.flip_h = false
	




func _initialize_attack():
	
	state_nxt = STATES.IDLE
	anim_nxt = "Attack"


func _state_attack(delta):
	
	
	
	move_and_slide(velocity, Vector2.UP)
	velocity. y += 500 * delta


func _initialize_dead():
	isDead = true
	state_nxt = STATES.DEAD
	anim_nxt = "Death"
	velocity.x *= 0

 
func _state_dead(delta):
	
	move_and_slide(velocity, Vector2.UP)
	velocity. y += 500 * delta




func takeDamage(damage : int):
	
	
	if isDead == false:
		anim_nxt = "Hit"
		health -= damage

func destroy():
	
	queue_free()



func _on_PatrolTimer_timeout():
	
	
	if turnAround == false:
		turnAround = true
	elif turnAround == true:
		turnAround = false



func _on_PlayerDetect_body_entered(body):
	
	var bodies = $Rotate/PlayerDetect.get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("Player"):
			
			playerIsInArea = true
			_initialize_attack()
			
			



func _on_PlayerDetect_body_exited(body):
	
	
	if body.is_in_group("Player"):
		
		playerIsInArea = false
		body.take_damage(5)
		






func _on_HitBox_body_entered(body):
	
	pass



func _on_HitBox_area_entered(area):
	
	if isDead == false:
		if area.is_in_group("BulletEnemy"):
			
			takeDamage(5)




#=========================
#         VFX
#=========================




func _blood_effect():
	
	var p = preload("res://Scenes/Particles/Blood.tscn").instance()
	
	p.position = $Position2D.global_position
	get_parent().add_child(p)






