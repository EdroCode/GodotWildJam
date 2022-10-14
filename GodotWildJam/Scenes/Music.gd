extends Node2D



func _ready():
	pass



func play_music():
	
	$AmbientMusic.play()
	$AmbientAir.play()
	$WaterAmbient.play()
	$ambientnoises.play()
	$Grow.play()
	$PoliceBackground.play()
	$SirensBackground.play()
	$sirene.play()


func stop():
	
	
	$AmbientMusic.stop()
	$AmbientAir.stop()
	$WaterAmbient.stop()
	$ambientnoises.stop()
	$Grow.stop()
	$PoliceBackground.stop()
	$SirensBackground.stop()
	$sirene.stop()
	
func door_music_play():
	
	
	$DoorOpeningSound.play()



func reload_sound_play():
	
	
	$Ammo.play()



func sirens_sound():
	
	
	$SirensBackground.play()



func police_sound():
	
	
	$PoliceBackground.play()
	
	





