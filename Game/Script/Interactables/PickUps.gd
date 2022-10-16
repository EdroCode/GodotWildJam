extends Area2D

var inventory = preload("res://Game/Script/Inventory/Inventory.gd")
var inventoryDisplay = preload("res://Game/Script/Inventory/InventoryDisplay.gd")

export(Resource) var item = null

func _on_PickUps_body_entered(body):
	if body.name == 'Player':
		add_to_inventory(item)
		queue_free()

func add_to_inventory(pickup):
	for i in inventory.items:
		if inventory.items[i] == null:
			inventory.set_item(i, pickup)
			inventory.inventoryDisplay.update_inventory_display()
