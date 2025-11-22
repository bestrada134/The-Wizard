extends CharacterBody2D

@onready var sprite = $Sprite2D

const SPEED = 150.0
const SIMPLE = preload("res://scenes/spell_01.tscn")
const FIREBALL = preload("res://scenes/fireball.tscn")
var max_special: int = 3

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up","down")
	velocity = direction * SPEED
	move_and_slide()

func _process(_delta: float) -> void:
	var mouse_rotation = get_global_mouse_position()
	var shoot_direction = (mouse_rotation -global_position).normalized()

	if Input.is_action_just_pressed("shoot"):
		var spell = SIMPLE.instantiate()
		spell.global_position = global_position
		spell.dir = shoot_direction
		get_tree().root.add_child(spell)

	if Input.is_action_just_pressed("special"):
		var spread_angle_degrees = 30
		var angle_step = deg_to_rad(spread_angle_degrees) / (max_special - 1)
		var current_angle = -deg_to_rad(spread_angle_degrees) / 2
		for i in max_special:
			var spell = SIMPLE.instantiate()
			spell.global_position = global_position
			spell.dir = shoot_direction.rotated(current_angle)
			current_angle += angle_step
			get_tree().root.add_child(spell)

	if Input.is_action_just_pressed("fireball"):
		var spell = FIREBALL.instantiate()
		spell.global_position = global_position
		spell.dir = shoot_direction
		get_tree().root.add_child(spell)
