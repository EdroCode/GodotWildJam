
enum Items {
	ITEM1 = 0x3301
	ITEM2 = 0x4402,
	ITEM3 = 0x8804,
	ITEM4,
	ITEM5,
	ITEM6 = 0xFF07,
	ITEM7,
	ITEM8,
	ITEM9,
	BAD_ITEM = 0xDEAD
}
var chosen_recipe: Array = [0, 0, 0] 

func combine():
	return chosen_recipe[0] ^ (chosen_recipe[1] ^ chosen_recipe[2])

func craft(wanted_item):
	if !Items.has(wanted_item):
		return Items.BAD_ITEM
	var combination = combine()
	if wanted_item == (wanted_item  & combination):
		return wanted_item 
	else:
		return Items.BAD_ITEM
