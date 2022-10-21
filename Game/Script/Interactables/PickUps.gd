extends Area2D

var inventoryDisplay = preload("res://Game/Script/Inventory/InventoryDisplay.gd")

export(Resource) var item = null

func _on_PickUps_body_entered(body):
	if body.name == 'Player':
		add_to_inventory(item)
		queue_free()

func add_to_inventory(pickup):
	var index = -1
	index = Inventory.items.find(null, 0)
	Inventory.set_item(index, pickup)
	inventoryDisplay.update_inventory_display()
