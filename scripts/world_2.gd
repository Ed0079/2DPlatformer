extends Node2D

@export var level_pos : Node2D
@onready var cheat= Global.get_cheat()
var stringy ="lifes x"+str(Global.get_lifes())
#updates the players spawn and the players ui
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
	
