extends "ScrollMovement.gd"


func _physics_process(delta):
	move()


func _on_Pickup_body_entered(body):
	if body.name == "Player":
		Signals.emit_signal("toggleMount")
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
