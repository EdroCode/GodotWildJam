extends Node

var drag_data = null

signal items_changed(indexes)

var craftitems = [null, null]

func set_item(item_index, item):
	var previousItem = craftitems[item_index]
	craftitems[item_index] = item
	emit_signal("items_changed", [item_index])
	return previousItem

func swap_items(item_index, target_item_index):
	var targetItem = craftitems[target_item_index]
	var item = craftitems[item_index]
	craftitems[target_item_index] = item
	craftitems[item_index] = targetItem
	emit_signal("items_changed", [item_index, target_item_index])

func remove_item(item_index):
	var previousItem = craftitems[item_index]
	craftitems[item_index] = null
	emit_signal("items_changed", [item_index])
	return previousItem

func make_items_unique():
	var unique_items = []
	for item in craftitems:
		if item is Item:
			unique_items.append(item.duplicate())
		else:
			unique_items.append(null)
	craftitems = unique_items
