extends CanvasLayer
func _ready():
	set_pause(false)

func set_pause(boolean):
	for node in get_children():
			node.visible = boolean

func _unhandled_input(event):
	if event.is_action_pressed("ui_page_up"):
		set_pause(false)
		get_tree().paused = false
