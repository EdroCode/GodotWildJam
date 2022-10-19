extends Area2D



var player = null
signal running


func can_see_player():
	return !(player == null)

func _on_PlayerDetectionZone_body_entered(body):
	
	if body.is_in_group("Player"):
		
		player = body
		emit_signal("running")
		
		

func _on_PlayerDetectionZone_body_exited(body):
	player = null
	get_parent().playerIsRunning = false
