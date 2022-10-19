extends Node

var drag_data = null

signal items_changed(indexes)
signal update_inventory_display()
func _ready():
	get_node("/root/Map/Bush").connect("_add_item", self, "set_item")
	get_node("/root/Map/Player").connect("quick_check", self, "most_recent_items")
	get_node("/root/Map/Rubbish").connect("_add_item", self, "set_item")

export(Array) var items = [
	null, null, null, null, null, null, null, null, null
]

func most_recent_items():
	print(items.slice(1,4))
#shifts array right
func shift_array():
	var arr = items.slice(1,8)
	for i in range(1, 8):
		items[i+1] = arr[i]
	swap_items(0,1)


func set_item(item_index, item):
	items[item_index] = item
	shift_array()
	var previousItem = items[item_index+1]
	emit_signal("items_changed", [item_index])
	return previousItem

func swap_items(item_index, target_item_index):
	var targetItem = items[target_item_index]
	var item = items[item_index]
	items[target_item_index] = item
	items[item_index] = targetItem
	emit_signal("items_changed", [item_index, target_item_index])

func remove_item(item_index):
	var previousItem = items[item_index]
	items[item_index] = null
	emit_signal("items_changed", [item_index])
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
			emit_signal("update_inventory_display")
