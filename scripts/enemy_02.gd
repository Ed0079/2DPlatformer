class_name enemy
extends CharacterBody2D
@onready var ap=$AnimationPlayer
@export var score = 250
@export var target_to_chase: CharacterBody2D
var entered = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_right=false
var click= false
var check=true
var speed = -25
var set_speed = -25
func _physics_process(delta):
	#Basic movement and will follow player if it enters the 
	#line of sight also it increases speed if the player is closer.
	#If its not on the floor for a while it will despawn it
	velocity.y += gravity * delta
	if click==false:
		velocity.x = speed
	if click:
		velocity.x=-speed
	if entered:
			
			var direction = position.direction_to(target_to_chase.position)*speed
			velocity.x=-direction.x		
			
			if velocity.x <0:
				
				if click==true:
					
					scale.x = abs(scale.x) * -1
					
					click=false
					
			elif velocity.x >0:
				
				if click==false:
					scale.x = abs(scale.x) * -1
					
					click=true
						
	move_and_slide()
	if is_on_floor()==false && check==true:
		
		$Timer.start()
		check=false
	elif is_on_floor() && check==false:
		$Timer.stop()
		check=true
	if !$RayCast2D.is_colliding() && is_on_floor() or is_on_wall():
		
		flip()
	
func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else :
		speed = abs(speed)*-1
#Event handlers
func _on_hitbox_body_entered(body):
	#after player enters the hitbox the danger zone will be disable , the player velocity will increase and an audio file will start
	if body.is_in_group("player"):
		$DangerZone.process_mode = 4
		$AudioStreamPlayer.play()
		body.velocity.y=-350
	
func _on_sight_body_exited(body):
	#slows down enemy when the player escapes its sight
	if body.is_in_group("player"):
		ap.play("slow_move")
		speed = set_speed
		entered=false

func _on_sight_body_entered(body):
	#This will unlock a code in process to allow the enmy to follow the player
	if body.is_in_group("player"):
		speed = -45
		entered=true
		ap.play("slow_move")

func _on_close_area_body_entered(body):
	#gives the enemy double speed and a new attack
	
	if body.is_in_group("player"):
		speed = speed*2
		ap.play("attack")

func _on_close_area_body_exited(body):
	#sets everything back to normal
	if body.is_in_group("player"):
		speed= set_speed
		ap.play("slow_move")

func _on_timer_timeout():
	
	queue_free()

func _on_audio_stream_player_finished():
	#set the score and despawn enemy
	Global.set_score(score)
	queue_free()
