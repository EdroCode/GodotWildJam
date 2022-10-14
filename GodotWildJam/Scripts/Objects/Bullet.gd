extends KinematicBody2D


var vel =  Vector2.ZERO
var speed : int = 250


func _ready():
	pass
	


func _physics_process(delta):
	
	scale -= scale * delta
	
	move_and_slide(vel  * speed)
	
	
	



func _on_Area2D_body_entered(body):
	
	
	
	if body.is_in_group("Map"):
		queue_free()
	
	if body.is_in_group("Enemy"):
		
		queue_free()
	
	if body.is_in_group("Player"):
		
		pass








