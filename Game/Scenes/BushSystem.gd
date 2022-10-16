extends KinematicBody2D


var stopSearch : bool = false
var canSearch : bool = false
var playerIsInArea : bool = false
export var numberOfItems : int

func _ready():
	
	
	pass


func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_page_down"):
		restart()
		
	
	
	if Input.is_action_just_pressed("Search"):
		
		if playerIsInArea == true:
			
			Search()


func Search():
	
	
	var luck = int(rand_range(0,2))
	
	
	if numberOfItems > 0:
		
		if luck == 0:
			
			print("Nothing Found")
			numberOfItems -= 1
		
		elif luck == 1:
			
			print("You Found an Item")
			numberOfItems -= 1
		
		
	elif numberOfItems <= 0:
		
		numberOfItems = 0
		print("You alredy search this")




func restart():
	
	#this is only for testing purposes
	
	numberOfItems = 1
	
	
	
	pass



func _on_SearchZone_body_entered(body):
	
	
	if body.is_in_group("Player"):
		
		playerIsInArea = true


func _on_SearchZone_body_exited(body):
	
	if body.is_in_group("Player"):
		
		playerIsInArea = false
