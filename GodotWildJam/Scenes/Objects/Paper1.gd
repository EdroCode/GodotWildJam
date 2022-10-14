extends Area2D



export(String) var paperText = ""


func _ready():
	
	pass




func _on_Paper1_body_entered(body):
	
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("Player"):
			$AudioStreamPlayer2D.play()
			Globals.TextOnScreen = paperText


func _on_Paper1_body_exited(body):

	if body.is_in_group("Player"):
		$AudioStreamPlayer2D.play()
		Globals.TextOnScreen = ""
