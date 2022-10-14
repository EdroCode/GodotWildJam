extends CanvasLayer


func _ready():
	pass


func _input(event):
	
	
	if event.is_action_pressed("Pause"):
		
		$Button.visible = !$Button.visible
		$TextureRect.visible = !$TextureRect.visible
		get_tree().paused = !get_tree().paused


func _on_Button_button_down():
	
	$Button.visible = !$Button.visible
	$TextureRect.visible = !$TextureRect.visible
	get_tree().paused = !get_tree().paused
