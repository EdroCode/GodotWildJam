extends Node2D

var inventoryScene = preload("res://Game/Scenes/InventoryContainer.tscn")

func _input(event):
	if Input.is_action_just_pressed("Inventory"):
		var inventory = inventoryScene.instance()
		$UI.add_child(inventory)
		if Input.is_action_just_pressed("Exit"):
			$UI.remove_child(inventory)
