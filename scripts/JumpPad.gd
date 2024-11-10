extends Sprite2D

#Gives the player y velocity when entered
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		$AudioStreamPlayer2D.play()
		body.velocity.y=-950
		
