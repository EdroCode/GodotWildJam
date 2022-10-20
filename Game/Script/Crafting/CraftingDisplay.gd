extends GridContainer

func _ready():
	Inventory.connect("items_changed", self, "_on_items_changed")
	Inventory.make_items_unique()
	update_inventory_display()

func update_inventory_display():
	for item_index in Inventory.items.size():
		update_inventory_slot_display(item_index)

func update_inventory_slot_display(item_index):
	var inventorySlotDisplay = get_child(item_index)
	var item = Inventory.items[item_index]
	inventorySlotDisplay.display_item(item)

func _on_items_changed(indexes):
	for item_index in indexes:
		update_inventory_slot_display(item_index)

func _unhandled_input(event):
	if event.is_action_released("ui_left_mouse"):
		if Inventory.drag_data is Dictionary:
			Inventory.set_item(Inventory.drag_data.item_index, Inventory.drag_data.item)
