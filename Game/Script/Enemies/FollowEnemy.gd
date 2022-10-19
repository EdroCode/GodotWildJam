extends "res://Game/Script/Enemies/Enemy.gd"



signal kill_player

func _ready():
	
	pass
	



func attack():
	print("Gotcha!")
	emit_signal("kill_player")

func _on_Enemy_attack_player():
	attack()
	pass # Replace with function body.







onready var _b1 := get_parent().get_node("FollowEnemy")
onready var _b2 := get_parent().get_node("Player")
var direction := ""
var playerIsRunning
var lastDirection

onready var anim = $AnimationPlayer

func _physics_process(delta):
	
	# Angle Calculation
	var angle = _b1.position.angle_to_point(_b2.position)
	
	
	
	if angle >= 0.1:
		direction = "up"
		lastDirection = "up"
	elif angle <= -0.1:
		direction = "down"
		lastDirection = "down"
	
	
	if playerIsRunning == true:
		
		
		
		if direction == "up":
			
			anim.play("RunUp")
			
		elif direction == "down":
			
			anim.play("RunDown")
			
		
	else:
		
		
		
		if lastDirection == "up":
			
			anim.play("IdleUp")
			
		elif lastDirection == "down":
			
			anim.play("IdleDown")
			
	
	
	
	  




func _on_PlayerDetectionZone_running():
	
	
	playerIsRunning = true


func shake():
	
	
	Globals.camera.shake(300, .5, 300)



#==============================
# VFX
#==============================


func rock_effect():
	
	var p = preload("res://Game/Scenes/Particles/RockParticles.tscn").instance()
	p.position = $feetPos.global_position
	get_parent().add_child(p)
	
	
	
	
