extends KinematicBody2D
enum STATES {IDLE, RUN}
var state_cur : int
var state_nxt : int
var anim_cur = ""
var anim_nxt = "Idle(down)"
var vel = Vector2.ZERO
var speed = 200
var acceleration = 2000
var friction = acceleration / speed

signal quick_check

onready var anim = $AnimationPlayer

func _ready():
	pass

func _physics_process(delta):
	vel = Vector2()
	if state_cur != state_nxt:
		state_cur = state_nxt
	if anim_cur != anim_nxt:
		anim_cur = anim_nxt
		anim.play(anim_cur)
	match state_cur:
		STATES.IDLE:
			_state_idle(delta)
		STATES.RUN:
			_state_run(delta)

func _initialize_idle():
	state_nxt = STATES.IDLE
	anim_nxt = "Idle(down)"

func _state_idle(delta):
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		_initialize_run()
	if Input.is_action_pressed("quick_check"):
		emit_signal("quick_check")

func _initialize_run():
	state_nxt = STATES.RUN
	

func _state_run(delta):
	
	if Input.is_action_pressed("ui_down"):
		vel.y += 1
		anim_nxt = "Run(down)"
	if Input.is_action_pressed("ui_up"):
		vel.y -= 1
		anim_nxt = "Run(Up)"
	if Input.is_action_pressed("ui_right"):
		vel.x += 1
		anim_nxt = "Run(Side)"
		$Sprite.flip_h = false
	if Input.is_action_pressed("ui_left"):
		vel.x -= 1
		anim_nxt = "Run(Side)"
		$Sprite.flip_h = true
	if vel == Vector2.ZERO:
		_initialize_idle()
	
	move_and_slide(vel * speed)
	vel.normalized()
