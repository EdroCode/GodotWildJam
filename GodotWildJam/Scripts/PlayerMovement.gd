extends KinematicBody2D


enum STATES {IDLE, RUN, JUMP, FALL, ATTACK, DEAD}
var state_cur : int
var state_nxt : int


var anim_cur = ""
var anim_nxt = "Idle"


var velocity := Vector2.ZERO
var direction = ""


onready var anim = $AnimationPlayer



var health : int = 30
var isDead : bool = false

var bullets = 10

var canShot : bool = true

var suitState : int = 100


#-------PRELOAD--------

onready var bullet = preload("res://Scenes/Objects/Bullet.tscn")


func _ready():
	
	state_cur = -1
	
	Globals.bullets = bullets
	
	if suitState >= 50:
		
		get_parent().get_node("Glass").visible = false
		
	else:
		
		get_parent().get_node("Glass").visible = true
	
	



func _physics_process(delta):
	
	
	if Input.is_action_just_pressed("ui_home"):
		get_tree().change_scene("res://Scenes/Words/Map17.tscn")
	
	if anim_cur != anim_nxt:
		anim_cur = anim_nxt
		anim.play(anim_cur)
	
	
	if state_nxt != state_cur:
		state_cur = state_nxt

	
	if velocity.x >= 1:
		direction = "Right"
		$Rotate.scale.x = 1
	elif velocity.x <= -1:
		direction = "Left"
		$Rotate.scale.x = -1
	
	

	
	
	
	if health <= 0:
		
		if isDead == false:
			health = 0
			_initialize_dead()
	
	
	
	if bullets <= 0:
		
		bullets = 0
		canShot = false
	elif bullets >= 0:
		
		canShot = true
	
	$RichTextLabel.text = " " + str(bullets)
	
	
	match state_cur:
		STATES.IDLE:
			_state_idle(delta)
		STATES.RUN:
			_state_run(delta)
		STATES.JUMP:
			_state_jump(delta)
		STATES.FALL:
			_state_fall(delta)
		STATES.DEAD:
			_state_dead(delta)
		
	
	
	get_parent().get_node("Text/SuitState/RichTextLabel3").text = str(suitState) + "%"
	
	
	if suitState >= 50:
		
		get_parent().get_node("Glass").visible = false
		
	else:
		
		get_parent().get_node("Glass").visible = true
	
	
	print(health)
	






func _initialize_idle():
	state_nxt = STATES.IDLE
	velocity.x *= 0
	anim_nxt = "Idle"
	



func _state_idle(delta):
	
	
	velocity.y = velocity.y + 500 * delta
	move_and_slide(velocity, Vector2(0, -1))
	
	
	
	if Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		_initialize_run()
	
	if Input.is_action_just_pressed("Jump"):
		_initialize_jump()
	
	if Input.is_action_pressed("Attack"):
		
		if canShot == true:
			_initialize_attack()
	
	
	if not is_on_floor():
		_initialize_fall()




func _initialize_run():
	state_nxt = STATES.RUN
	anim_nxt = "Run"




func _state_run(delta):
	
	
	velocity.y = velocity.y + 500 * delta
	move_and_slide(velocity, Vector2(0, -1))
	
	if Input.is_action_pressed("Left"):
		velocity.x = -60
		$Sprite.flip_h = true
		
	elif Input.is_action_pressed("Right"):
		velocity.x = 60
		$Sprite.flip_h = false
	else:
		_initialize_idle()

	
	if Input.is_action_just_pressed("Jump"):
		_initialize_jump()
	
	if Input.is_action_pressed("Attack"):
		
		if canShot == true:
			_initialize_attack()
	
	if not is_on_floor():
		_initialize_fall()
	
	
	


func _initialize_jump():
	state_nxt = STATES.JUMP
	anim_nxt = "Jump"
	velocity.y = -150
	
	




func _state_jump(delta):
	velocity.y = velocity.y + 500 * delta
	move_and_slide(velocity, Vector2(0, -1))
	
	if Input.is_action_pressed("Left"):
		velocity.x = -60
		$Sprite.flip_h = true
		
	elif Input.is_action_pressed("Right"):
		velocity.x = 60
		$Sprite.flip_h = false
	
	
	
	
	if is_on_floor():
		if abs(velocity.x) > 10:
			_initialize_run()
		else:
			_initialize_idle()
	else:
		if velocity.y > 0:
			_initialize_fall()



func _initialize_fall():
	state_nxt = STATES.FALL
	anim_nxt = "Fall"
	

func _state_fall(delta):
	
	velocity.y = velocity.y + 500 * delta
	move_and_slide(velocity, Vector2(0, -1))
	
	
	if Input.is_action_pressed("Left"):
		velocity.x = -60
		$Sprite.flip_h = true
		
	elif Input.is_action_pressed("Right"):
		velocity.x = 60
		$Sprite.flip_h = false
	
	
	
	if is_on_floor():
		
		anim_nxt = "Ground"
		play_land_sound()
		
		if abs(velocity.x) > 10:
			_initialize_run()
		else:
			_initialize_idle()
	else:
		if velocity.y > 0:
			_initialize_fall()
	
	



func take_damage(damage : int):
	
	suitState -= 15
	anim_nxt = "Hit"
	health -= damage



func _initialize_dead():
	state_nxt = STATES.DEAD
	anim_nxt = "Dead"
	velocity.x *= 0
	isDead = true
	

func _state_dead(delta):
	velocity.y = velocity.y + 500 * delta
	move_and_slide(velocity, Vector2(0, -1))
	
	




func _initialize_attack():
	
	state_nxt = STATES.ATTACK
	anim_nxt = "Attack"
	Globals.camera.shake(650, .1, 650)
	$ShotSound.play()
	bullets -= 1
	
	var b
	
	
	b = bullet.instance()
	get_parent().add_child(b)
	b.position = $Rotate/ShotPos.global_position
	
	if $Sprite.flip_h == true: 
		b.vel.x = -1
	else:
		b.vel.x = 1


func _state_attack(delta):
	
	
	velocity.y = velocity.y + 500 * delta
	move_and_slide(velocity, Vector2(0, -1))




#=========================
#           VFX
#=========================



func play_reload_sound():
	
	
	$ReloadSound.play()

func play_hurt_sound():
	
	var last_step_sound
	var rand_footstep = floor(rand_range(0, 4))
	while rand_footstep == last_step_sound:
		rand_footstep = floor(rand_range(0, 1))
	
	match str(rand_footstep):
		
		"0":
			$HurtSound.stream = preload("res://Music/hurt1.mp3")
		"1":
			$HurtSound.stream = preload("res://Music/hurt2.mp3")
	
	$HurtSound.play()
	last_step_sound = rand_footstep
	
	

func play_jump_sound():
	
	$JumpSound.play()
	



func play_land_sound():
	
	$LandSound.play()
	




func play_sound():
	
	var last_step_sound
	var rand_footstep = floor(rand_range(0, 4))
	while rand_footstep == last_step_sound:
		rand_footstep = floor(rand_range(0, 4))
	
	match str(rand_footstep):
		
		"0":
			$FootStepSound.stream = preload("res://Music/footstep1.mp3")
		"1":
			$FootStepSound.stream = preload("res://Music/footstep2.mp3")
		"2":
			$FootStepSound.stream = preload("res://Music/footstep3.mp3")
		"3":
			$FootStepSound.stream = preload("res://Music/footstep4.mp3")
	
	$FootStepSound.play()
	last_step_sound = rand_footstep


func play_sound2():
	
	var last_step_sound
	var rand_footstep = floor(rand_range(0, 4))
	while rand_footstep == last_step_sound:
		rand_footstep = floor(rand_range(0, 4))
	
	match str(rand_footstep):
		
		"0":
			$FootStepSound2.stream = preload("res://Music/footstep1.mp3")
		"1":
			$FootStepSound2.stream = preload("res://Music/footstep2.mp3")
		"2":
			$FootStepSound2.stream = preload("res://Music/footstep3.mp3")
		"3":
			$FootStepSound2.stream = preload("res://Music/footstep4.mp3")
	
	$FootStepSound.play()
	last_step_sound = rand_footstep







func _jump_dust():
	
	var p = preload("res://Scenes/Particles/JumpDust.tscn").instance()
	p.position = position
	get_parent().add_child(p)






func _on_HitBox_area_entered(area):
	
	if isDead == false:
		
		if area.is_in_group("BulletEnemy"):
			
			take_damage(5)




func change_scene():
	
	Music.stop()
	get_tree().change_scene("res://Scenes/Words/DeathScene.tscn")



