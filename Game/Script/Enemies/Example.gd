extends "res://Game/Script/Enemies/Enemy.gd"

signal kill_player
func _ready():
	MAX_SPEED = 0
	
func attack():
	print("Gotcha!")
	emit_signal("kill_player")

func _on_Enemy_attack_player():
	attack()
	pass # Replace with function body.
