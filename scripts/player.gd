class_name player
extends CharacterBody2D

#variables
const SPEED = 400.0
const JUMP_VELOCITY = -550.0
@onready var ap=$AnimationPlayer
@onready var sprite = $Sprite2D
var can_control : bool = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var plat = Vector2(0,0)

func _ready():
	add_to_group("player")

func _physics_process(delta):
	# Add the gravity.
	if not can_control: return
	
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$AudioStreamPlayer2D.play()
		velocity.y = JUMP_VELOCITY
		velocity.x=plat.x

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction !=0:
		switch_direction(direction)
	update_animation(direction)
	move_and_slide()
	plat = get_platform_velocity()

func update_animation(direction):
	#Handles the animation changes
	if is_on_floor():
		if direction==0:
			ap.play("idle")
		else:
			ap.play("Run")
	else:
		if velocity.y<0:
			ap.play("Fall")
		elif velocity.y>0:
			ap.play("Jump")
	
func switch_direction(direction):
	#Handles the sprite direction
	sprite.flip_h=(direction==-1)

func handle_danger()-> void:
	#Handles the players death
	if Global.get_lifes()<=0 and Global.get_cheat()==false:
		
		var next_path = "res://scenes"
		var next_option_path = next_path+"/levels/game_over.tscn"
		get_tree().change_scene_to_file.bind(next_option_path).call_deferred()
	elif Global.get_cheat()==false:
		
		Global.set_lifes(1)
	visible=false
	can_control =false
	reset_player()
	
func reset_player()->void:
	#resets player postions and 
	position = Global.spawn_point
	$AnimationPlayer.play("respawn")
	$AnimatedSprite2D.play("smoke")
	await get_tree().create_timer(0.3).timeout
	
	visible=true
	can_control=true

