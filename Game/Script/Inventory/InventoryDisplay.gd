extends GridContainer

#var inventory = preload("res://Game/Script/Inventory/Inventory.tres")
var valid_items = preload("res://Game/Script/Inventory/ItemVars.gd").new()
var inv_slots = preload("res://Game/Scenes/UI/InventorySlotDisplay.tscn")
var drag_data = null
signal _set_item
export (Array, Resource) var items_res = [
	load("res://Game/Assets/Items/BluePotion.tres"), null,  null,  null,  null,  null,  null,  null,  null    
]


func make_items_unique(items):
	var unique_items = []
	for item in items:
		if valid_items.valids.has(item):
			unique_items.append(item)
		else:
			unique_items.append(null)


func _ready():
	#inventory.connect("items_changed", self, "_on_items_changed")
	#inventory.connect("update_inventory_display", self, update_inventory_display())
	#inventory.make_items_unique()
	#update_inventory_display()
	pass

func update_inventory_display(items):
	for item_index in items:
		
		update_inventory_slot_display(item_index)

func update_inventory_slot_display(item_index):
	if valid_items.valids.has(item_index):
		var inventorySlotDisplay = get_child(item_index)
		var item = items_res[item_index]
		inventorySlotDisplay.display_item(item)

func _on_items_changed(indexes):
	for item_index in indexes:
		update_inventory_slot_display(item_index)

func get_drag_data(_position):
	var item_index = get_index()
	if items_res[item_index] == null:
		return
	inv_slots.drag_item(items_res[item_index], item_index)

func drop_data(_position, data):
	var my_item_index = get_index()
	var my_item = items_res[my_item_index]
	if my_item is Item and my_item.name == data.item.name:
		my_item.amount += data.item.amount

func _unhandled_input(event):
	if event.is_action_released("ui_left_mouse"):
		if drag_data is Dictionary:
			emit_signal("_swap_item", my_item_index, data.item_index)
			emit_signal("_set_item", drag_data.item_index, drag_data.item)
