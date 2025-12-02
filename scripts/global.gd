extends Node

#player upgrades (further into)
var player_health = 100
var player_mana = 100
var player_max_mana = 100
var player_exp = 0
var player_max_exp = 100

#in game upgrades
var player_speed = 100
var spell_damage = 10
var basic = 0
var fireball = 50

#global checks
var play_special = true
var play_fireball = true
var new_round = false
var spawner_count = 5
var total_enemies = 40
var total_killed = 0

func end_reset():
	player_exp = 0
	player_max_exp = 100
	player_speed = 100
	spell_damage = 10
	spawner_count = 5
	total_killed = 0
	total_enemies = 40
