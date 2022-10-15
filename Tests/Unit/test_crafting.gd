extends GutTest

class TestCrafting:
	extends GutTest
	var crafting
	func before_all():
		crafting = load("res://Game/Script/Crafting/Crafting.gd").new()
		gut.p("ran setup", 2)
	func after_all():
		gut.p("ran cleanup", 2)
	func test_craft_success():
		var arr = [crafting.Items.ITEM1, crafting.Items.ITEM2, crafting.Items.ITEM3]
		var a  = crafting.craft(arr, crafting.Items.ITEM6)
		assert_eq(a, crafting.Items.ITEM6)
	func test_craft_failed():
		var arr = []
		var a  = crafting.craft(arr, crafting.Items.ITEM7)
		assert_eq(a, crafting.Items.BAD_ITEM)
	func test_craft_out_of_order():
		var arr = [crafting.Items.ITEM3, crafting.Items.ITEM1, crafting.Items.ITEM3]
		var a = crafting.craft(arr, crafting.Items.ITEM6)
		assert_eq(a, crafting.Items.ITEM6)
