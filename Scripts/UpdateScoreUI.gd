extends Label

func _process(delta):
	get_node(".").text = str(Global.current_score)
