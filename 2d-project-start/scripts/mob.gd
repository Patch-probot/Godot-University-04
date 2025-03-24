extends CharacterBody2D


@export var speed: float = 425
@export var distance_buffer: int = 100
@onready var player: CharacterBody2D = $/root/Main/Player
@onready var mob: Node2D = %Slime
@onready var timer: Timer = $/root/Main/SpawnTimer
var health: int = 3

func _ready() -> void:
	mob.play_walk()
	
func _physics_process(delta: float) -> void:
	var direction: Vector2 = global_position.direction_to(player.global_position)
	velocity = direction * speed
	
	var distance: float = global_transform.origin.distance_to(player.global_transform.origin)
	if distance >= distance_buffer:
		move_and_slide()
	else:
		move_and_collide(direction * 1.6)

func take_damage():
	health -= 1
	
	%Slime.play_hurt()
	
	if health <= 0:
		queue_free()
		if randf() > 0.9 and timer.wait_time > 0.1:
			timer.wait_time -= 0.01
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
