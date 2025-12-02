extends Control

@onready var animation = $AnimationPlayer
@onready var animation2= $AnimationPlayer2
@onready var upgrades = $upgrades
@onready var health_label = $player_state/HBoxContainer/Health
@onready var mana_label = $player_state/HBoxContainer/Mana
@onready var exp_label = $player_state/HBoxContainer/Exp
@onready var death = $Death_Scene
var gui_visible = true


var url = "https://uselessfacts.jsph.pl/api/v2/facts/random"
@onready var http = $Death_Scene/HTTPRequest
@onready var fact = $Death_Scene/VBoxContainer/Fact

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("special") and Global.play_special:
		animation.play("special")
		Global.play_special = false
	if Input.is_action_just_pressed("fireball") and Global.play_fireball:
		animation2.play("fireball")
		Global.play_fireball = false

func _ready() -> void:
	update_stats()

func display_upgrades():
	get_tree().paused = gui_visible
	upgrades.visible = gui_visible
	gui_visible = !gui_visible

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	Global.play_special = true

func _on_button_pressed() -> void:
	Global.spell_damage += 5
	display_upgrades()

func _on_button_2_pressed() -> void:
	animation.speed_scale += 0.1
	display_upgrades()

func _on_button_3_pressed() -> void:
	Global.player_speed += 5
	display_upgrades()

func _on_animation_player_2_animation_finished(_anim_name: StringName) -> void:
	Global.play_fireball = true

func update_stats():
	health_label.text = "Health: " + str(Global.player_health) + "/100"
	mana_label.text = "Mana: " + str(Global.player_mana) + "/" + str(Global.player_max_mana)
	exp_label.text = "Exp: " + str(Global.player_exp) + "/" + str(Global.player_max_exp)


func end_game():
	get_tree().paused = true
	http.request(url)
	death.visible = true


func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")


func _on_http_request_request_completed(_result: int, _response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	var data = JSON.parse_string(body.get_string_from_utf8())
	print(data.text)
	fact.text = "DID YOU KNOW: \n" + str(data.text)
