extends CanvasLayer

export(String, FILE, "*.tscn, *.scn") var target_scene
export(String, FILE, "*.tscn, *.scn") var opt_target_scene






func _on_PlayButton_button_down():
	
	get_tree().change_scene(target_scene)


func _on_OptionsButton_button_down():	
	
	get_tree().change_scene(opt_target_scene)


func _on_QuitButton_button_down():
	
	get_tree().quit()
