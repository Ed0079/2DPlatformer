extends Control

var next_path = "res://scenes"
#Starts the game
func _on_start_pressed():
	Global.set_world(1)
	var next_level_path = next_path+"/tools/load_screen.tscn"
	get_tree().change_scene_to_file.bind(next_level_path).call_deferred()
#Loads settings
func _on_setting_pressed():
	var next_option_path = next_path+"/levels/settings.tscn"
	get_tree().change_scene_to_file.bind(next_option_path).call_deferred()

func _on_exit_pressed():
	get_tree().quit()


func _on_link_button_pressed():
	OS.shell_open('https://github.com/Ed0079')
