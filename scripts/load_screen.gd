extends Control
#variables
var progress=[]
var sceneName
var scene_load_status = 0
# 
func _ready():
	#Prepares the scene based on the current game world.
	if Global.get_world()==4:
			sceneName = "res://scenes/levels/credits.tscn"
	else:
			sceneName = "res://scenes/levels/world_" + str(Global.get_world())+".tscn"
	ResourceLoader.load_threaded_request(sceneName)
	
func _process(delta):
	#Monitors the status of the scene loading process and updates the UI.
	scene_load_status= ResourceLoader.load_threaded_get_status(sceneName,progress)
	$loading_count.text=str(floor(progress[0]*100))+"%"
	if scene_load_status==ResourceLoader.THREAD_LOAD_LOADED:
		var newScene =ResourceLoader.load_threaded_get(sceneName)
		get_tree().change_scene_to_packed(newScene)
