extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var round_timer = $Rounds
@export var igui : Control

const SIMPLE = preload("res://scenes/spell_01.tscn")
const FIREBALL = preload("res://scenes/fireball.tscn")
var max_special: int = 3
signal new_round



func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up","down")
	velocity = direction * Global.player_speed
	move_and_slide()

func _process(_delta: float) -> void:
	check_end_round()
	if Global.player_exp >= Global.player_max_exp:
		Global.player_exp = 0
		Global.player_max_exp += 10
		igui.update_stats()
		igui.display_upgrades()

	var mouse_rotation = get_global_mouse_position()
	var shoot_direction = (mouse_rotation - global_position).normalized()

	if Input.is_action_just_pressed("shoot"):
		var spell = SIMPLE.instantiate()
		spell.global_position = global_position
		spell.dir = shoot_direction
		get_tree().root.add_child(spell)
		Global.player_mana -= 1
		igui.update_stats()

	if Input.is_action_just_pressed("special") and Global.play_special:
		Global.player_mana -= 3
		var spread_angle_degrees = 30
		var angle_step = deg_to_rad(spread_angle_degrees) / (max_special - 1)
		var current_angle = -deg_to_rad(spread_angle_degrees) / 2
		for i in max_special:
			var spell = SIMPLE.instantiate()
			spell.global_position = global_position
			spell.dir = shoot_direction.rotated(current_angle)
			current_angle += angle_step
			get_tree().root.add_child(spell)
			
		igui.update_stats()

	if Input.is_action_just_pressed("fireball") and Global.play_fireball:
		Global.player_mana -= 8
		var spell = FIREBALL.instantiate()
		spell.global_position = global_position
		spell.dir = shoot_direction
		get_tree().root.add_child(spell)
		igui.update_stats()
	


func _on_hitbox_area_entered(_area: Area2D) -> void:
	Global.player_health -= 5
	igui.update_stats()

func check_end_round():
	if Global.total_killed == Global.total_enemies:
		Global.total_killed = 0;
		Global.spawner_count += 1
		Global.total_enemies = Global.spawner_count * 8
		round_timer.start()

func _on_timer_timeout() -> void:
	if Global.player_mana < 100:
		Global.player_mana += 3
	igui.update_stats()


func _on_rounds_timeout() -> void:
	emit_signal("new_round")
