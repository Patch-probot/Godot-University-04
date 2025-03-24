extends CharacterBody2D

@export var speed: int = 600
@onready var player: Node2D = %HappyBoo
var health: float = 100.0
signal health_depleted

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()

	if velocity.length() > 50.0:
		player.play_walk_animation()
	else:
		player.play_idle_animation()

	const DAMAGE_RATE = 25.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			pass
			health_depleted.emit()
