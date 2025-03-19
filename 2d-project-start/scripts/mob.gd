extends CharacterBody2D


@export var speed: float = 300
@export var distance_buffer: int = 100
@onready var player: CharacterBody2D = $/root/Main/Player
@onready var mob: Node2D = %Slime

func _physics_process(delta: float) -> void:
	var direction: Vector2 = global_position.direction_to(player.global_position)
	velocity = direction * speed
	
	var distance: float = global_transform.origin.distance_to(player.global_transform.origin)
	if distance >= distance_buffer:
		move_and_slide()
		mob.play_walk()
	else:
		move_and_collide(direction * 1.6)
		mob.play_walk()
