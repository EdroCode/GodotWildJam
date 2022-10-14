extends KinematicBody2D


enum STATES {IDLE, PATROL, ATTACK, DEAD}

var state_cur : int
var state_nxt : int

var anim_cur = ""
var anim_nxt = "Patrol"


var velocity = Vector2.ZERO
var turnAround = false
var isDead = false

var health : int = 10



onready var anim = $AnimationPlayer
onready var patrolTimer = $PatrolTimer
onready var shotDelay = $ShotDelay
onready var bullet = preload("res://Scenes/Objects/BulletEnemy.tscn")




func _ready():
	
	state_cur = -1
	state_nxt = STATES.PATROL
	patrolTimer.start()
	
	
	
	$ZombieGrunt.play()
	$ZombieGrunt2.play()
	


func _physics_process(delta):
	
	if state_cur != state_nxt:
		state_cur = state_nxt
	
	if anim_cur != anim_nxt:
		anim_cur = anim_nxt
		anim.play(anim_cur)
	
	if velocity.x > 1:
		$Sprite.flip_h = false
		$Rotate.scale.x = 1
	elif velocity.x < -1:
		$Sprite.flip_h = true
		$Rotate.scale.x = -1
	
	
	if health <= 0:
		
		health = 0
		_initialize_dead()
	
	if isDead == false:
		
		match state_cur:
			
			STATES.IDLE:
				_state_idle(delta)
			STATES.PATROL:
				_state_patrol(delta)
			STATES.ATTACK:
				_state_attack(delta)
			STATES.DEAD:
				_state_dead(delta)
	
	
	if Input.is_action_just_pressed("ui_page_down"):
		
		_initialize_attack()
	
	



func _initialize_idle():
	
	state_nxt = STATES.IDLE
	anim_nxt = "Idle"
	velocity.x *= 0



func _state_idle(delta):
	
	velocity.y += 500 * delta
	move_and_slide(velocity, Vector2.UP)
	
	

func _initialize_patrol():
	
	state_nxt = STATES.IDLE
	anim_nxt = "Patrol"
	velocity.x *= 0



func _state_patrol(delta):
	
	velocity.y += 500 * delta
	move_and_slide(velocity, Vector2.UP)
	
	if turnAround == true:
		velocity.x = 45
	elif turnAround == false:
		velocity.x = -45
	



func _initialize_attack():
	
	state_nxt = STATES.ATTACK
	anim_nxt = "Attack"
	shotDelay.start()



func _state_attack(delta):
	
	pass



func _initialize_dead():
	
	state_nxt = STATES.DEAD
	anim_nxt = "Dead"
	velocity.x *= 0
	isDead = true
	
	$ZombieGrunt.stop()
	$ZombieGrunt2.stop()
	


func _state_dead(delta):
	
	velocity.x *= 0
	
	
	




func play_reload_sound():
	
	
	$ReloadSound.play()




func _on_PatrolTimer_timeout():
	
	
	if turnAround == false:
		turnAround = true
	elif turnAround == true:
		turnAround = false


func _on_ShotDelay_timeout():
	
	if isDead == false:
		
		
		$ShotSound.play()
		
		var b
		
		
		Globals.camera.shake(650, .1, 650)
		anim_nxt = "Attack"
		b = bullet.instance()
		get_parent().add_child(b)
		b.position = $Rotate/ShotPos.global_position
		
		if $Sprite.flip_h == true: 
			b.vel.x = -1
		else:
			b.vel.x = 1




func takeDamage(damage : int):
	
	
	if isDead == false:
		anim_nxt = "Hit"
		health -= damage



func _on_PlayerDetect_body_entered(body):
	
	if isDead == false:
	
		if body.is_in_group("Player"):
			_initialize_attack()
	


func _on_Area2D_area_entered(area):
	
	
	if isDead == false:
		
		if area.is_in_group("Bullet"):
			
			takeDamage(5)
