extends Sprite2D

@export var check : Sprite2D

func _ready():
	$AnimationPlayer.play("Idel")
func _on_area_2d_body_entered(body):
	#sets players global postion with some animation callbacks
	if body.is_in_group("player"):
		
		$AnimationPlayer.play("RESET")
		Global.update_spawn(check.position)
