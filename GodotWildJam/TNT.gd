extends Area2D



export(String) var paperText = ""
var playerIsInArea : bool

func _ready():
	
	pass




func _on_Area2D_body_entered(body):
	
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("Player"):
			playerIsInArea = true

func _process(delta):
	
	
	
	print(playerIsInArea)
	
	
	if playerIsInArea == true:
		if Input.is_action_just_pressed("Explode"):
					Globals.camera.shake(4650, .5, 4650)
					$AudioStreamPlayer.play()
					$Timer.start()



func _on_Timer_timeout():
	
	get_tree().change_scene("res://Scenes/FinalScene.tscn")


func _on_Area2D_body_exited(body):
	
	playerIsInArea = false
