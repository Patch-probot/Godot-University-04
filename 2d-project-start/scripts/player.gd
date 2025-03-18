extends CharacterBody2D

@export var speed = 100
@onready var player = %HappyBoo

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()

	if velocity.length() > 0.0:
		player.play_walk_animation()
	else:
		player.play_idle_animation()
