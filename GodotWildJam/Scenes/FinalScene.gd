extends Node2D


func _ready():
	pass


func _on_Button_button_down():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
