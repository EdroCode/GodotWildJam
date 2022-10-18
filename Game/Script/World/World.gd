extends Node
onready var groups = []
onready var Player = get_tree().get_nodes_in_group("Player")
onready var Enemies = get_tree().get_nodes_in_group("Enemies")
onready var Interactables = get_tree().get_nodes_in_group("Interactables")
func _ready():
	for group in get_groups():
		if not group.begins_with("_"):
				groups.push_back(group)

func _on_Enemy_kill_player():
	var p  = Player.pop_front()
	p.free()
	print("Game Over")
	pass # Replace with function body.
