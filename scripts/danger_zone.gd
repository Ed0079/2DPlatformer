extends Area2D

func _on_body_entered(body):
	#Handles the event when the player enters the designated area. 
	#In this circumstance it active the 'death' event
	if body is player:
		
		body.handle_danger()
		
