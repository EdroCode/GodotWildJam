extends Area2D
var vals = preload("res://Game/Script/Inventory/ItemVars.gd").new()
var item = vals.Items.ITEM1
signal _add_item
func _on_PickUps_body_entered(body):
	if body.name == 'Player':
		emit_signal("_add_item", item, 0)
		queue_free()

