extends Node2D

var playerIsInArea = true





func _physics_process(delta):
	
	
	
	if playerIsInArea == true:
		
		if Input.is_action_just_pressed("Search"):
			
			
			
			get_tree().change_scene("res://Game/Scenes/Map.tscn")









func _on_Area2D_body_entered(body):
	playerIsInArea = true


func _on_Area2D_body_exited(body):
	playerIsInArea = false
