extends CanvasLayer


func _ready():
	pass


func _on_HSlider_value_changed(value):
	
	set_bus_volume(1, value)
	$ColorRect/MusicSlider/Value.text = "%d%%" % (value)
	


func set_bus_volume(bus_index : int, value : float):
	
	
	AudioServer.set_bus_volume_db(bus_index, linear2db(value))
	AudioServer.set_bus_mute(bus_index, value < 0.01)
	pass





func _on_Button_button_down():
	
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
