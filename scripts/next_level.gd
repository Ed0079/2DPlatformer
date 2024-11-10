extends Area2D
#Takes the player to the loading screen
func _on_body_entered(body):
	if body.is_in_group("player"):
		var current_level = get_tree().current_scene.scene_file_path
		var next_level = current_level.to_int()+1
		Global.set_world(next_level)
	
		var next_level_path = "res://scenes/tools/load_screen.tscn"
	
		get_tree().change_scene_to_file.bind(next_level_path).call_deferred()
		
