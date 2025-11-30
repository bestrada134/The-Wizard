extends Node2D

const knight = preload("res://scenes/enemy.tscn")
var enemy_limit = 20

func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	pass

func choose_enemy():
	var enemy = knight.instantiate()
	enemy.global_position = global_position
	enemy.name = "enemy"
	get_tree().root.add_child(enemy)


func _on_timer_timeout() -> void:
	if enemy_limit >= 0:
		choose_enemy()
		enemy_limit -= 1
