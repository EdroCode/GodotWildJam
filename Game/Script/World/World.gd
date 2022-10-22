extends Node
# Singleton handling State of all Active and 
# Interctable .

onready var groups = []
onready var Player = get_tree().get_nodes_in_group("Player")
onready var Enemies = get_tree().get_nodes_in_group("Enemies")
onready var Interactables = get_tree().get_nodes_in_group("Interactables")
onready var inv_ui = get_node("/root/Map/GUI")
var validation = preload("res://Game/Script/Inventory/ItemVars.gd").new().valids
func _unhandled_input(event):
	if Input.is_action_pressed("Inventory"):
		pause_for_inv()
func _ready():
	Player[0].connect("call_inv_menu", self, "pause_for_inv")
	for group in get_groups():
		if not group.begins_with("_"):
				groups.push_back(group)

func pause_for_inv():
	inv_ui.get_child(0).set_pause(true)
	get_tree().paused = !get_tree().paused
	
func finish_game():
	for i in range(0,9):
		if !Inventory.items.has(validation[i]):
			return
	print("You win!")



