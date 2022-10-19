extends Area2D
class_name PickUps
var vals = preload("res://Game/Script/Inventory/ItemVars.gd").new()
export(int) var item_val 
signal _add_item
func _on_PickUps_body_entered(body):
	if body.name == 'Player':
		emit_signal("_add_item", 0, item_val)
		queue_free()

