extends Node2D

export var scroll_speed = 6.3

func move():
	self.position.x -= scroll_speed
