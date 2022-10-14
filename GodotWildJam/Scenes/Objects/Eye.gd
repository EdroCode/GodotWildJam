extends Area2D


func _ready():
	
	
	$AnimationPlayer.play("idle")


func _on_Eye_body_entered(body):
	
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("Player"):
			$AnimationPlayer.play("New Anim")


func _on_Eye_body_exited(body):
	
	
	if body.is_in_group("Player"):
		$AnimationPlayer.play("idle")
