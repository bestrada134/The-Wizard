extends Node2D
var save_path = "res://upgrades.save"
var health = 100
var damage = 10
var mana = 100


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_data()
	Global.player_health = health
	Global.player_mana = mana
	Global.player_max_mana = mana
	Global.spell_damage = damage


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		health = file.get_var(health)
		damage = file.get_var(damage)
		mana = file.get_var(mana)
	else:
		health = 100
		damage = 10
		mana = 100
