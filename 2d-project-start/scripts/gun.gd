extends Area2D

@onready var pistol: Sprite2D = $WeaponPivot/Pistol
@onready var player: CharacterBody2D = $/root/Main/Player

var front_enemy_distance: float

func _physics_process(delta: float) -> void:
	var enemies_in_range: Array = get_overlapping_bodies()
	for enemy in enemies_in_range.size():
		if enemies_in_range[enemy].global_position.distance_to(global_position) < enemies_in_range[0].global_position.distance_to(player.global_position):
			print("old distance: ", front_enemy_distance)
			enemies_in_range.push_front(enemies_in_range.pop_at(enemy))
			print(enemy, " is ", front_enemy_distance)


	
	if enemies_in_range.size() > 0:
		var target_enemey = enemies_in_range.front()
		look_at(target_enemey.global_position)
		
	if global_rotation_degrees <= -90 or global_rotation_degrees >= 90:
			pistol.flip_v = true
	else:
		pistol.flip_v = false

func shoot():
	const FLASH = preload("res://pistol/muzzle_flash/muzzle_flash.tscn")
	const BULLET = preload("res://scenes/bullet.tscn")
	var new_bullet: Area2D = BULLET.instantiate()
	var new_flash: Node2D = FLASH.instantiate()
	
	new_bullet.global_rotation = %Boom.global_rotation
	new_flash.global_rotation = %Boom.global_rotation
	if global_rotation_degrees <= -90 or global_rotation_degrees >= 90:
		new_bullet.global_position = %BoomFlipped.global_position
		new_flash.global_position = %BoomFlipped.global_position 
	else:
		new_bullet.global_position = %Boom.global_position
		new_flash.global_position = %Boom.global_position
		
	%Boom.add_child(new_bullet)
	%Boom.add_child(new_flash)
		

func _on_timer_timeout() -> void:
	shoot()
