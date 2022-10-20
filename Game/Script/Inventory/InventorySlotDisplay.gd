extends CenterContainer


onready var itemTextureRect = $ItemTextureRect
onready var itemAmountLabel = $ItemTextureRect/ItemAmountLabel

func display_item(item):
	if item is Item:
		itemTextureRect.texture = item.texture
		itemAmountLabel.text = str(item.amount)
	else:
		itemTextureRect.texture = load("res://Assets/Items/EmptyInventorySlot.png")
		itemAmountLabel.text = ""

func get_drag_data(_position):
	var item_index = get_index()
	var item = Inventory.remove_item(item_index)
	if item is Item:
		var data = {}
		data.item = item
		data.item_index = item_index
		var dragPreview = TextureRect.new()
		dragPreview.texture = item.texture
		set_drag_preview(dragPreview)
		Inventory.drag_data = data
		return data

func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")

func drop_data(_position, data):
	var my_item_index = get_index()
	var my_item = Inventory.items[my_item_index]
	
	if my_item is Item and my_item.name == data.item.name:
		my_item.amount += data.item.amount
		Inventory.emit_signal("items_changed", [my_item_index])
	else:
		Inventory.swap_items(my_item_index, data.item_index)
		Inventory.set_item(my_item_index, data.item)
	Inventory.drag_data = null
