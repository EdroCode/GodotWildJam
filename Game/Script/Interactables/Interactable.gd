extends StaticBody2D
var stopSearch : bool = false
var canSearch : bool = false
var playerIsInArea : bool = false
var vals = preload("res://Game/Script/Inventory/ItemVars.gd").new()
export var numberOfItems : int
export(int) var item_val
signal _add_item
export(Texture) var texture
export(PackedScene) var particle

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_page_down"):
		restart()
	if Input.is_action_just_pressed("Search"):
		if playerIsInArea == true:
			Search()

func _physics_process(delta):
	pass
	#$Sprite.texture = texture

func Search():
	
	#$AnimationPlayer.play("Searching")
	var luck = 1
	if numberOfItems > 0:
		if luck == 0:
			
			print("Nothing Found")
			numberOfItems -= 1
		elif luck == 1:
			numberOfItems -= 1
			emit_signal("_add_item", 0, item_val)
	elif numberOfItems <= 0:
		numberOfItems = 0
		print("You alredy search this")

func restart():
	numberOfItems = 1
	pass

func _on_SearchZone_body_entered(body):
	if body.is_in_group("Player"):
		playerIsInArea = true

func _on_SearchZone_body_exited(body):
	if body.is_in_group("Player"):
		playerIsInArea = false
		









#====================
#        VFX
#====================




func leaf_particle():
	
	var p = particle.instance()
	p.position = position
	get_parent().add_child(p)
	
	







