extends KinematicBody2D

var velocity = Vector2.ZERO

export var jump_velocity = 600.0
export var gravity_scale = 30.0

var score = 0

enum {
	JUMP,
	RUN,
	IDLE
}

var state = RUN

onready var animation = $AnimatedSprite
onready var animationMount = $AnimationPlayer

func _ready():
	Global.current_score = 0
	Signals.connect("rewardplayer", self, "rewardplayer")
	Signals.connect("killplayer", self, "killplayer")
	Signals.connect("toggleMount", self, "toggleMount")
	Signals.connect("endgame", self, "endgame")

func _physics_process(delta):
	match state:
		RUN:
			animation.play("Run")
			animationMount.play("Run")
		JUMP:
			velocity = Vector2.ZERO
			velocity.y -= jump_velocity
			animation.play("Jump")
			animationMount.play("Jump")
			state = IDLE
		IDLE:
			pass
	
	velocity.y += gravity_scale
	move_and_collide(velocity*delta)

func _input(event):
	if state == RUN:
		if event.is_action_pressed("Jump"):
			state = JUMP

func _on_Area2D_body_entered(body):
	if body is StaticBody2D:
		state = RUN

func _on_Area2D_body_exited(body):
	if body is StaticBody2D:
		state = JUMP

func rewardplayer(scoreToAdd):
	score += scoreToAdd
	print(score)

func toggleMount():
	if get_node("Mount").visible == true && get_node("Player").visible == true:
		get_node("AnimatedSprite").visible = false
	if get_node("Mount").visible == false && get_node("Player").visible == false:
		get_node("Mount").visible = true
		get_node("Player").visible = true
		get_node("AnimatedSprite").visible = false
		animationMount.playback_speed = 2

func killplayer():
	if get_node("Mount").visible == true && get_node("Player").visible == true:
		get_node("Mount").visible = false
		get_node("Player").visible = false
		get_node("AnimatedSprite").visible = true
		animationMount.playback_speed = 1
	else:
		Signals.emit_signal("endgame")
		
func endgame():
	queue_free()
