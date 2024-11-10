extends Node2D
@export var level_pos : Node2D
@onready var cheat= Global.get_cheat()
var stringy ="lifes x"+str(Global.get_lifes())
#updates the players spawn, the players ui, and checks if the boss is dead
func _ready():
	if cheat :
		stringy ="lifes xinfinity"
	$player_ui_layer/player_ui/score_counter.text=str(Global.get_score())
	$player_ui_layer/player_ui/lives_counter.text=stringy
	Global.update_spawn(level_pos.position)

func _process(delta):
	if cheat ==false:
		stringy ="lifes x"+str(Global.get_lifes())
	$player_ui_layer/player_ui/score_counter.text=str(Global.get_score())
	$player_ui_layer/player_ui/lives_counter.text=stringy

func boss_death_event():
	
	$AnimationPlayer.play("door")
	$next_level.process_mode = 1 
	$AnimationPlayer.play("portal_spawn")
	
	#clearing music
	pass

func _on_timer_timeout():
	if Global.get_boss_death():
	
		boss_death_event()
		Global.set_boss_death(false)
	else:
		pass
