extends Control

var onscreen = Vector2(0, 0)
var offscreen = Vector2(1024, 0)

onready var options = $Options
onready var about = $About
onready var menu = $VBoxContainer

func _on_StartGame_pressed():
	get_tree().change_scene("res://Game/Scenes/Map.tscn")

func _on_Options_pressed():
	options.rect_position = onscreen
	menu.rect_position = offscreen

func _on_About_pressed():
	about.rect_position = onscreen
	menu.rect_position = offscreen

func _on_Quit_pressed():
	get_tree().quit()
