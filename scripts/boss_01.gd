extends CharacterBody2D
#modable modifier
@export var phase=1
@export var target_to_chase: CharacterBody2D
@export var  base_speed = 300
@export var  dash_speed = 500.0
@export var  jump_speed = 400.0
@export var score = 1000
@export var set_counter=5
#node vars
@onready var timer = $Timer
@onready var animated_sprite= $AnimatedSprite2D
@onready var animation_player= $AnimationPlayer
#variables
#variables that are poly depending on the function
var counter = set_counter
var speed = base_speed
#boolean locks for phases and mechanics
var facing_right=false
var insight = false
var trigger = true
var check_one= true
var check_two=true
var check_three=true
var check_four=true
var random_number= RandomNumberGenerator.new()
var combo_number=1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	#the phases determin the attack pathern
	if phase==1:
		dash()
	if phase==2:
		
		jump()
	if phase==3:
		combo()

	move_and_slide()

#movement functions
func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else :
		speed = abs(speed)*-1
#movesets
func dash():
	#if player is in "sight" of the boss it will dash and the trigger is active
	var modifier=speed
	
	if insight and trigger:
		
		modifier = dash_speed
		var direction = position.direction_to(target_to_chase.position)
		if direction.x<0 and check_one:
			
			dash_speed = abs(dash_speed)*-1
			check_one=false
		elif direction.x>0 and check_one:
			dash_speed = abs(dash_speed)
			check_one=false
	
	#if the bosss collids with the wall it will "jump" and "flip" and will become idel for a time
	if $RayCast2D.is_colliding() or is_on_wall():
			
			animation_player.play("jump")
			animated_sprite.play("jump")
			flip()
			idel()
	else:
		velocity.x = modifier

func jump():
	#keeps jumping intil the 'counter' reaches 0
	if check_two:
		animation_player.play("jump")
		animated_sprite.play("jump")
		check_two=false
	
	if $RayCast2D.is_colliding() or is_on_wall():
			flip()
			counter = counter-1
			if counter ==0:
				check_three=false
				
				idel()
	velocity.x = speed

func combo():
	#a combination of "super attack" and "jump". 
	#when it hits the random number generator picks a number between 1 to 2
	#after a while it slows down
	var modifier=speed
	if check_four:
		animated_sprite.play("super_attack")
		animation_player.play("run")
		check_four=false
	if combo_number==1:
		modifier = dash_speed
	elif combo_number ==2:
		
		modifier = jump_speed
	if $RayCast2D.is_colliding() or is_on_wall():
		combo_number = random_number.randi_range(1,2)
		slowdown()
		flip()
	if facing_right:
			modifier = abs(modifier)
	else :
			modifier = abs(modifier)*-1
	speed = modifier
	velocity.x = speed
#methods
func idel():
	#Resets triggers and starts the cooldown timer for the boss.
	#This function checks the current phase of the boss. If the boss is in phase 1
	#and the trigger is active, it resets the trigger to false. In phase 2, if 
	#the condition `check_three` is false, it starts the timer and sets the speed 
	# to 0.
	if trigger and phase==1:
		trigger = false
	elif check_three==false and phase==2:
		timer.start()
		speed=0

func start():
	#Initializes the boss's speed based on its facing direction.
	if facing_right:
			speed = abs(base_speed)
	else :
			speed = abs(base_speed)*-1

func slowdown():
	#Reduces the boss's speed gradually by 25
	if speed==0:
		speed=0
	else:
		speed= abs(speed)-25
	if facing_right:
		speed = abs(speed)
	else :
		speed = abs(speed)*-1
#node functions
func _on_animation_player_animation_finished(anim_name):
	#Handles actions based on the completion of an animation.
	if anim_name=="jump" and phase==1:
		animated_sprite.play("default")
		animation_player.play("RESET")
		if trigger==false:
			speed=0
			timer.start()
			
	if anim_name=="jump" and phase==2 and check_two==false:
		animation_player.play("jump")
		animated_sprite.play("jump")
	if anim_name=="jump" and phase==2 and check_three==false:
		animated_sprite.play("default")
		animation_player.play("RESET")
	
	if anim_name=="run" and phase==3:
		if combo_number==1:
			animated_sprite.play("super_attack")
			animation_player.play("run")
		elif combo_number==2:
			animated_sprite.play("jump")
			animation_player.play("jump")
	if anim_name=="jump" and phase==3:
		if combo_number==1:
			animated_sprite.play("super_attack")
			animation_player.play("run")
		elif combo_number==2:
			animated_sprite.play("jump")
			animation_player.play("jump")

func _on_sight_body_entered(body):
	#Triggers actions when player enters the boss's sight
	if body.is_in_group("player") and phase==1:
		insight=true
		if trigger:
			animated_sprite.play("run")
			animation_player.play("run")

func _on_hitbox_body_entered(body):
	#Handles the event when player enters the boss's hitbox.
	if body.is_in_group("player") :
		$AudioStreamPlayer.play()
		
		body.velocity.y=-650
		if body.velocity.y<0:
			body.velocity.x=-250
		else:
			body.velocity.x=250
		if phase!=3:
			phase=phase+1
			
		else:
			Global.set_score(score)
			Global.set_boss_death(true)
			queue_free()	

func _on_timer_timeout():
	#This function resets the trigger and starts the boss's behavior based on its current phase.
	if phase==1:
		trigger=true
		start()
	if phase==2:
		start()
		check_three=true
		counter=set_counter

func _on_sight_body_exited(body):
	#when player exits the boss's sight it resets the values
	if body.is_in_group("player") and phase==1:
		insight=false
		check_one=true
		animated_sprite.play("default")
		animation_player.play("RESET")
