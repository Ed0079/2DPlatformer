extends Area2D
@export var score=50
var coin=0


func _on_body_entered(body):
		#plays the 'pickup' animation and set/updates the score
		if body.is_in_group("player"):
			$AnimationPlayer.play("pickup")
			Global.set_score(score)
			
		
