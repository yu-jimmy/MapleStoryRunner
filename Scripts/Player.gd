extends KinematicBody2D

var velocity = Vector2.ZERO

export var jump_velocity = 600.0
export var gravity_scale = 20.0

var score = 0

enum {
	JUMP,
	RUN,
	IDLE
}

var state = RUN

onready var animation = $AnimatedSprite

func _ready():
	Signals.connect("rewardplayer", self, "rewardplayer")
	Signals.connect("killplayer", self, "killplayer")

func _physics_process(delta):
	match state:
		RUN:
			animation.play("Run")
		JUMP:
			velocity = Vector2.ZERO
			velocity.y -= jump_velocity
			animation.play("Jump")
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
	Signals.emit_signal("upatescore",score)
	print(score)

func killplayer():
	queue_free()
