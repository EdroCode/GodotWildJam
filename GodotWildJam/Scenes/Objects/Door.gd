extends Area2D

export(String, FILE, "*.tscn, *.scn") var target_scene
export(String) var code

export(bool) var doorHaveCode



func _ready():
	
	if doorHaveCode == true:
		
		$LineEdit.visible = true
		
	else:
		
		$LineEdit.visible = false




func _input(event):
	
	if doorHaveCode == false:
		
		$LineEdit.visible = false
		
		if Input.is_action_just_pressed("OpenDoor"):
			if get_overlapping_bodies().size() > 1:
				if !target_scene: # is null
					print("no scene in this door")
					return
				
				
				next_level()
			
		
	elif doorHaveCode == true:
		
		$LineEdit.visible = true
		
		if $LineEdit.text == code:
			if Input.is_action_just_pressed("OpenDoor"):
				if get_overlapping_bodies().size() > 1:
					if !target_scene: # is null
						print("no scene in this door")
						return
					
					next_level()




func next_level():
	
	
	var ERR = get_tree().change_scene(target_scene)
	
	if ERR != OK:
		print("something failed in the door scene")
		
	Music.door_music_play()
	
	

func _on_LineEdit_text_changed(new_text):
	
	$BeepSound.play()
