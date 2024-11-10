extends CharacterBody2D

#variables
const SPEED = 75.0
@export var score = 100
@onready var ap=$AnimationPlayer
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_right=false
var check=true
var speed = -25

func _physics_process(delta):
	#basic movement and if they fall or aren't on the floor they despawn
	ap.play("move")
	velocity.y += gravity * delta
	velocity.x = speed
	move_and_slide()
	if is_on_floor()==false && check==true:
		$Timer.start()
		check=false
	elif is_on_floor() && check==false:
		$Timer.stop()
		check=true
	if !$RayCast2D.is_colliding() && is_on_floor() or is_on_wall():
		
		flip()

func _on_hitbox_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#after player enters the hitbox the danger zone will be disable , the player velocity will increase and an audio file will start
	if body.is_in_group("player"):
		$DangerZone.process_mode = 4
		$AudioStreamPlayer.play()
		body.velocity.y=-300

func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else :
		speed = abs(speed)*-1

func _on_timer_timeout():
	queue_free()

func _on_audio_stream_player_finished():
	#set the score and despawn enemy
	Global.set_score(score)
	queue_free()
	
