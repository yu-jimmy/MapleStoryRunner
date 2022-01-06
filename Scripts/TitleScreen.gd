extends Control

func _ready():
	if Global.current_score > Global.high_score:
		Global.high_score = Global.current_score
	$HighScore.text = "Highscore: " + str(Global.high_score)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Scenes/Game.tscn")
