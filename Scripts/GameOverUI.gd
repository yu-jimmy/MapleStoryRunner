extends Control

func _ready():
	Signals.connect("killplayer",self,"gameover")


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")

func gameover():
	self.show()
