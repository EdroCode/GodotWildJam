
enum Items {
	ITEM1,
	ITEM2,
	ITEM3,
	ITEM4,
	ITEM5,
	ITEM6,
	ITEM7,
	ITEM8,
	ITEM9,
	BAD_ITEM
}

var Recipes = { Items.ITEM6: [Items.ITEM1, Items.ITEM2, Items.ITEM3]}


func craft(item_arr, wanted_item):
	if !Recipes.has(wanted_item):
		return Items.BAD_ITEM
	if item_arr == Recipes[wanted_item]:
		return wanted_item
	elif Recipes[wanted_item].has(item_arr[0]):
		for item in item_arr:
			if !Recipes[wanted_item].has(item):
				return Items.BAD_ITEM
		return wanted_item
	else:
		return Items.BAD_ITEM
