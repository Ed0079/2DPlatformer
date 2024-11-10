
extends Control
#variables for the audio buses
var master_bus = AudioServer.get_bus_index("Master")
var stage_bus = AudioServer.get_bus_index("Stage")
var effects_bus = AudioServer.get_bus_index("Effects")
# Handles the pause ability
func _on_pause_pressed():
	if get_tree().paused==false:
		
		$pause.text="resume"
		get_tree().paused=true
	
	elif get_tree().paused:
		$pause.text="pause"
		get_tree().paused=false
		

#Handles the ability to mute
func _on_mute_pressed():
		AudioServer.set_bus_mute(master_bus, not AudioServer.is_bus_mute(master_bus))
		AudioServer.set_bus_mute(stage_bus, not AudioServer.is_bus_mute(stage_bus))
		AudioServer.set_bus_mute(effects_bus, not AudioServer.is_bus_mute(effects_bus))
		if $mute.text=="mute":
			$mute.text="unmute"
			
		else :
			$mute.text="mute"
