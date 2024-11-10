extends Control

var next_path = "res://scenes"

#Goes back to the start menu
func _on_back_pressed():
		var next_option_path = next_path+"/levels/start_menu.tscn"
		get_tree().change_scene_to_file.bind(next_option_path).call_deferred()

#Activates the cheats
func _on_unlimited_lifes_pressed():
	var cheat=false
	if $ItemList/VBoxContainer/unlimited_lifes.button_pressed:
		cheat=true
	Global.set_cheat(cheat)
	print(Global.get_cheat())
