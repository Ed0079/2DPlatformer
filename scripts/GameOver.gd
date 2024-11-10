extends CanvasLayer

#
func _on_menu_pressed():
	#returns you to the start menu
	var next_path = "res://scenes"
	var next_option_path = next_path+"/levels/start_menu.tscn"
	get_tree().change_scene_to_file.bind(next_option_path).call_deferred()


func _on_retry_pressed():
	#restarts the current level
	var next_level_path = "res://scenes/tools/load_screen.tscn"
	
	get_tree().change_scene_to_file.bind(next_level_path).call_deferred()


func _on_exit_pressed():
	get_tree().quit()
