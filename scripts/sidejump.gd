extends Sprite2D


#Gives the player y & x velocity when entered
@export var x : float
@export var y : float

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		$AudioStreamPlayer.play()
		body.velocity.y= y
		body.velocity.x= x
		
