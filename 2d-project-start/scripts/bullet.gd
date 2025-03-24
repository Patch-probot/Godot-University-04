extends Area2D

@export var speed: int = 1000
var travelled_distance: int = 0

func _physics_process(delta: float) -> void:
	const RANGE = 1200
	var direction: Vector2 = Vector2.RIGHT.rotated(rotation)
	
	position += direction * speed * delta
	travelled_distance += speed * delta
	
	if travelled_distance > RANGE:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
