extends Node2D

export var scroll_speed = 6.3

func move():
	if (Global.current_score >= 5 and Global.current_score <= 10):
		scroll_speed = 7.3
	elif (Global.current_score > 10 and Global.current_score <= 20):
		scroll_speed = 8.3
	elif (Global.current_score > 20):
		scroll_speed = 9.3
	self.position.x -= scroll_speed
