extends Area2D

@onready var player: CharacterBody2D = $/root/Main/Player
@onready var sprite: Sprite2D = $Sprite
@onready var animation: AnimationPlayer = $Sprite/AnimationPlayer
var trees_in_range: Array

func _physics_process(delta: float) -> void:

	trees_in_range = get_overlapping_bodies()
	for trees in trees_in_range.size():
		if trees_in_range[trees].global_position.distance_to(player.global_position) < trees_in_range[0].global_position.distance_to(player.global_position):
			trees_in_range.push_front(trees_in_range.pop_at(trees))
		
	if trees_in_range:
		show()
		sprite.global_position = trees_in_range.front().global_position
		sprite.look_at(player.global_position)
	else:
		hide()
	
	if player.global_position < sprite.global_position:
		if sprite.flip_v == false:
			animation.stop()
			
		sprite.flip_v = true
		sprite.global_position.x -= 30
	else:
		if sprite.flip_v == true:
			animation.stop()
		sprite.global_position.x += 30
		sprite.flip_v = false


func swing():
	if sprite.flip_v:
		animation.play("swing_flipped")
	else:
		animation.play("swing")
	if trees_in_range:	
		if trees_in_range.front().has_method("take_swing_damage"):
			var tree = trees_in_range.front()
			await get_tree().create_timer(0.5).timeout
			tree.take_swing_damage()

func _on_timer_timeout() -> void:
	swing()# Replace with function body.
