extends Node2D

const knight = preload("res://scenes/enemy.tscn")
const knight2 = preload("res://scenes/enemy_02.tscn")
const knight3 = preload("res://scenes/enemy_03.tscn")
@onready var timer = $Timer
@onready var player = get_tree().get_first_node_in_group("Player")


var enemy_limit = 5

func _ready() -> void:
	player.connect("new_round", reset)


func _process(_delta: float) -> void:
	pass

func reset():
	enemy_limit = Global.spawner_count

func choose_enemy():
	var num = randi_range(1,3)
	var enemy
	if num == 1:
		enemy = knight.instantiate()
	elif num == 2:
		enemy = knight2.instantiate()
	else:
		enemy = knight3.instantiate()

	#var enemy = knight.instantiate()
	enemy.global_position = global_position
	enemy.name = "enemy"
	get_tree().root.add_child(enemy)


func _on_timer_timeout() -> void:
	if enemy_limit >= 0:
		choose_enemy()
		enemy_limit -= 1
	var time = randf_range(0.5, 3.0)
	timer.start(time)
	
