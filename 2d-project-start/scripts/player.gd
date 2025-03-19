extends CharacterBody2D

@export var speed: int = 600
@onready var player: Node2D = %HappyBoo

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()

	if velocity.length() > 50.0:
		player.play_walk_animation()
	else:
		player.play_idle_animation()
