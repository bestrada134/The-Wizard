extends CharacterBody2D

var SPEED = 20
var Health = 20
var Player_in = false

@onready var player = get_tree().get_first_node_in_group("Player")

func _physics_process(_delta: float) -> void:
	var direction = position.direction_to(player.global_position).normalized()
	velocity = direction * SPEED
	move_and_slide()


func _on_detect_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		SPEED = 60
func _on_detect_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		SPEED = 20

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "spell":
		take_damage(Global.basic + Global.spell_damage)
	if area.name == "Fireball" or area.name == "AoE":
		take_damage(Global.fireball + Global.spell_damage)

func take_damage(dmg):
	Health -= dmg
	if Health <= 0:
		queue_free()
		Global.player_exp += 5
		Global.total_killed += 1
	
