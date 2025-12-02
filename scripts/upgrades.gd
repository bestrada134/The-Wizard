extends Control

@onready var points_label = $MarginContainer/VBoxContainer/Label
@onready var health_label = $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Label2
@onready var damage_label = $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Label3
@onready var mana_label = $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Label4


var save_path = "res://upgrades.save"
var health = 100
var damage = 10
var mana = 100
var upgrade_points = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_data()
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	save()
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")


func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(health)
	file.store_var(damage)
	file.store_var(mana)
	file.store_var(upgrade_points)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		health = file.get_var(health)
		damage = file.get_var(damage)
		mana = file.get_var(mana)
		upgrade_points = file.get_var(upgrade_points)
	else:
		health = 100
		damage = 10
		mana = 100
		upgrade_points = 5

func update():
	points_label.text = "Upgrade Points: " + str(upgrade_points)
	health_label.text = "Health: " + str(health)
	damage_label.text = "Bonus Damage: " + str(damage)
	mana_label.text = "Mana: " + str(mana)


func _on_health_pressed() -> void:
	if upgrade_points != 0:
		health += 10
		upgrade_points -= 1
		update()


func _on_dmg_pressed() -> void:
	if upgrade_points != 0:
		damage += 2
		upgrade_points -= 1
		update()


func _on_mana_pressed() -> void:
	if upgrade_points != 0:
		mana += 5
		upgrade_points -= 1
		update()
