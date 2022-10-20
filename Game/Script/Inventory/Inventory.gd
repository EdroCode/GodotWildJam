extends Node

var drag_data = null
onready var  ui = get_node("/root/Map/GUI")

signal items_changed(indexes)
signal update_inventory_display()

export(Array) var items = [
	null, null, null, null, null, null, null, null, null
]

func _ready():
	get_node("/root/Map/Bush").connect("_add_item", self, "set_item")
	get_node("/root/Map/Player").connect("quick_check", self, "most_recent_items")
	get_node("/root/Map/Player").connect("call_inv_menu", self, "_on_Player_call_inv_menu")
	get_node("/root/Map/Rubbish").connect("_add_item", self, "set_item")
	#inv_ui.make_items_unique(items)
	inv_ui.update_inventory_display(items)
	inv_ui.connect("_set_item", self, "set_item")
onready var inv_ui = get_node("/root/Map/GUI/UI/InventoryContainer/CenterContainer/InventoryDisplay")

func _on_Player_call_inv_menu():
	print("a")

func most_recent_items():
	print(items.slice(1,4))
#shifts array right
func shift_array():
	var arr = items.slice(0,9)
	for i in range(1, 9):
		items[i] = arr[i-1]
	#swap_items(0,1)


func set_item(item_index, item):
	items[item_index] = item
	shift_array()
	var previousItem = items[item_index+1]
	inv_ui.update_inventory_display(items)
	return previousItem

func swap_items(item_index, target_item_index):
	var targetItem = items[target_item_index]
	var item = items[item_index]
	items[target_item_index] = item
	items[item_index] = targetItem
	#emit_signal("items_changed", [item_index, target_item_index])
	inv_ui.update_inventory_slot_display([item_index, target_item_index])

func remove_item(item_index):
	var previousItem = items[item_index]
	items[item_index] = null
	#emit_signal("items_removed", previousItem)
	inv_ui.update_inventory_slot_display([item_index])
	return previousItem

func make_items_unique():
	var unique_items = []
	for item in items:
		if item is Item:
			unique_items.append(item.duplicate())
		else:
			unique_items.append(null)
	items = unique_items

func add_to_inventory_ui(pickup):
	for i in items:
		if items[i] == null:
			#emit_signal("update_inventory_display")
			inv_ui.update_inventory_display()
