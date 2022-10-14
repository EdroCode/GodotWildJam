extends Area2D


func _ready():
	
	pass



func _on_Ammo_body_entered(body):
	
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("Player"):
			body.bullets += 5
			Music.reload_sound_play()
			queue_free()




