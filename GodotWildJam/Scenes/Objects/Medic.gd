extends Area2D




func _ready():
	
	pass




func _on_MedicKit_body_entered(body):
	
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("Player"):
			
			body.take_damage(-10)
			queue_free()




func _on_MedicKit_body_exited(body):
	
	
	if body.is_in_group("Player"):
		pass
