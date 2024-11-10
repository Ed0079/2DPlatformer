extends Node
#variables
var spawn_point = Vector2(0,0)
var boss_death=false
var world_lvl=0
var unlimited_lives=false
var lives=3
var score=0000
var set_goal=1000
#updates the players spawn
func update_spawn(new_point):
	spawn_point=new_point
#set and gets
func set_boss_death(check):
	boss_death=check

func get_boss_death():
	return boss_death

func set_lifes(i):
	lives=lives-i

func get_lifes():
	return lives

func set_cheat(i):
	unlimited_lives=i

func get_cheat():
	return unlimited_lives

func set_world(i):
	world_lvl=i

func get_world():
	return world_lvl

func set_score(i):
	score=score+i
	#if it passes the goal lives gets a plus one
	if score>=set_goal:
		lives= lives + 1
		set_goal= score + set_goal
	
func get_score():
	return score
