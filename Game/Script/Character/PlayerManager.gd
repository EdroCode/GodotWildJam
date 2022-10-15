extends KinematicBody2D
enum STATES {IDLE, RUN}
var state_cur : int
var state_nxt : int
var anim_cur = ""
var anim_nxt = "Idle"
var vel = Vector2.ZERO
var speed = 200
var acceleration = 2000
var friction = acceleration / speed

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
	print("Idle")
	state_nxt = STATES.IDLE
	#anim_nxt = "Idle"

func _state_idle(delta):
	if Input.is_action_pressed("Down") or Input.is_action_pressed("Up") or Input.is_action_pressed("Right") or Input.is_action_pressed("Left"):
		_initialize_run()

func _initialize_run():
	state_nxt = STATES.RUN
	#anim_nxt = "Run"

func _state_run(delta):
	
	if Input.is_action_pressed("Down"):
		vel.y += 1
	if Input.is_action_pressed("Up"):
		vel.y -= 1
	if Input.is_action_pressed("Right"):
		vel.x += 1
	if Input.is_action_pressed("Left"):
		vel.x -= 1
	if vel == Vector2.ZERO:
		_initialize_idle()
	
	move_and_slide(vel * speed)
	vel.normalized()
