extends Area2D

@onready var weapon_pivot: Marker2D = $WeaponPivot
@onready var pistol: Sprite2D = $WeaponPivot/Pistol
@onready var player: CharacterBody2D = $/root/Main/Player
@onready var area1: Area2D = %Area1
@onready var area2: Area2D = %Area2
@onready var area3: Area2D = %Area3
@onready var area4: Area2D = %Area4
@onready var area5: Area2D = %Area5
@onready var area6: Area2D = %Area6
@onready var area7: Area2D = %Area7
@onready var area8: Area2D = %Area8
# IMPORTANT DOCUMENTATION 
# set extra pistol count to 0 to have the gun working
# any other values are for testing multiple guns and is not functional
var extra_pistol_count: int = 0
var pistol_count: Array
var pistol_targets: Array

func _ready() -> void:
	area1.body_entered.connect(_on_area1_entered)
	area1.body_exited.connect(_on_area1_exited)
	area2.body_entered.connect(_on_area2_entered)
	area2.body_exited.connect(_on_area2_exited)
	area3.body_entered.connect(_on_area3_entered)
	area3.body_exited.connect(_on_area3_exited)
	area4.body_entered.connect(_on_area4_entered)
	area4.body_exited.connect(_on_area4_exited)
	area5.body_entered.connect(_on_area5_entered)
	area5.body_exited.connect(_on_area5_exited)
	area6.body_entered.connect(_on_area6_entered)
	area6.body_exited.connect(_on_area6_exited)
	area7.body_entered.connect(_on_area7_entered)
	area7.body_exited.connect(_on_area1_exited)
	area8.body_entered.connect(_on_area8_entered)
	area8.body_exited.connect(_on_area8_exited)

	pistol_count.append(weapon_pivot)
	for pistols in extra_pistol_count:
		var duplicate = weapon_pivot.duplicate()
		add_child(duplicate)
		pistol_count.append(duplicate)

func _physics_process(delta: float) -> void:
	var enemies_in_range: Array = get_overlapping_bodies()
	
	for lists in area_target_lists.size():
		if pistol_count.size() == 1 and enemies_in_range.size() > 0:
			var target_enemy = enemies_in_range.front()
			if target_enemy:
				weapon_pivot.look_at(target_enemy.global_position)
		elif pistol_count.size() == 2:	
			pass
		elif pistol_count.size() == 4:	
			pass
		else:
			pass
			
		for bodies in area_target_lists[lists].size():
			pass
			#FOR
				#put the distance check here 
		
	if enemies_in_range:
		show()
	else:
		hide()

	for enemy in enemies_in_range.size():
		if enemies_in_range[enemy].global_position.distance_to(player.global_position) < enemies_in_range[0].global_position.distance_to(player.global_position):
			enemies_in_range.push_front(enemies_in_range.pop_at(enemy))
		
	if pistol.global_rotation_degrees <= -90 or pistol.global_rotation_degrees >= 90:
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

var area_target_lists: Array = [[],[],[],[],[],[],[],[]]

func _on_timer_timeout() -> void:
	shoot()

func _on_area1_entered(body):
	area_target_lists[0].append(body)

func _on_area1_exited(body):
	area_target_lists[0].erase(body)
	
func _on_area2_entered(body):
	area_target_lists[1].append(body)
	
func _on_area2_exited(body):
	area_target_lists[1].erase(body)

func _on_area3_entered(body):
	area_target_lists[2].append(body)
	
func _on_area3_exited(body):
	area_target_lists[2].erase(body)
	
func _on_area4_entered(body):
	area_target_lists[3].append(body)
	
func _on_area4_exited(body):
	area_target_lists[3].erase(body)
	
func _on_area5_entered(body):
	area_target_lists[4].append(body)
	
func _on_area5_exited(body):
	area_target_lists[4].erase(body)
	
func _on_area6_entered(body):
	area_target_lists[5].append(body)
	
func _on_area6_exited(body):
	area_target_lists[5].erase(body)
	
func _on_area7_entered(body):
	area_target_lists[6].append(body)
	
func _on_area7_exited(body):
	area_target_lists[6].erase(body)
	
func _on_area8_entered(body):
	area_target_lists[7].append(body)
	
func _on_area8_exited(body):
	area_target_lists[7].erase(body)
	
