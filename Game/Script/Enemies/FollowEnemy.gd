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







var direction = Vector2.ZERO
var playerIsRunning
var lastDirection

onready var anim = $AnimationPlayer

func _physics_process(delta):
	
	
	
	
	
	if velocity.y >= 0.01:
		
		direction = "down"
		
	elif velocity.y <= -0.01:
		
		direction = "up"
		
	
	
	if velocity.x == 0 and velocity.y == 0:
		
		anim.play("Idle")
	
	
	
	if playerIsRunning == true:
		
		
		
		if direction == "up":
			
			anim.play("RunUp")
			
		elif direction == "down":
			
			anim.play("RunDown")
			
		
	
	  




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
	$feetPos.add_child(p)
	 
	
	
	

