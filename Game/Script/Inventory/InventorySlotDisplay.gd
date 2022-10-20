extends CenterContainer

#var inventory = preload("res://Game/Script/Inventory/Inventory.tres")

onready var itemTextureRect = $ItemTextureRect
onready var itemAmountLabel = $ItemTextureRect/ItemAmountLabel

func display_item(item):
	if item == null: return
	if item is Item:
		itemTextureRect.texture = item.texture
		itemAmountLabel.text = str(item.amount)
	else:
		itemTextureRect.texture = load("res://Assets/Items/EmptyInventorySlot.png")
		itemAmountLabel.text = ""

func drag_item(item, item_index):
	var drag_data = null
	if item is Item:
		var data = {}
		data.item = item
		data.item_index = item_index
		var dragPreview = TextureRect.new()
		dragPreview.texture = item.texture
		set_drag_preview(dragPreview)
		drag_data = data
		return data

func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")

func drop_data(_position, data):
	var my_item_index = get_index()
	var my_item = 0 #inventory.items[my_item_index]
	
	if my_item is Item and my_item.name == data.item.name:
		my_item.amount += data.item.amount
		#inventory.emit_signal("items_changed", [my_item_index])
	#else:
		#inventory.swap_items(my_item_index, data.item_index)
		#inventory.set_item(my_item_index, data.item)
	#inventory.drag_data = null
