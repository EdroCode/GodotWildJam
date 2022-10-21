extends "res://Game/Script/Interactables/Interactable.gd"

var search_sound = preload("res://Game/Assets/Sound/Search_1.wav")

func _ready():
	item_val = vals.Items.ITEM5

func Search():
	
	if !$AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.stream = search_sound
		$AudioStreamPlayer2D.play()
		
	.Search()
