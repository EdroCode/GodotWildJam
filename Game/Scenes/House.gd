extends KinematicBody2D

var playerIsInArea = false
var playerIsInHouse = false

func _ready():
	
	pass


func _physics_process(delta):
	
	if playerIsInHouse == true:
		
		get_parent().get_parent().get_node("Player").position = get_parent().get_parent().get_node("SpawnPoints/HouseLeft").position
	
	if playerIsInArea == true:
		
		if Input.is_action_just_pressed("Search"):
			
			playerIsInArea = true
			get_tree().change_scene("res://Game/Scenes/HouseInterior.tscn")







func _on_EnterArea_body_entered(body):
	
	playerIsInArea = true


func _on_EnterArea_body_exited(body):
	
	playerIsInArea = false
