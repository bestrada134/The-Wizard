extends Control

@onready var animation = $AnimationPlayer
@onready var upgrades = $upgrades
var gui_visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("special") and Global.play_special:
		animation.play("special")
		Global.play_special = false
	if Input.is_action_just_pressed("fireball") and Global.play_fireball:
		animation.play("fireball")
		Global.play_fireball = false



func display_upgrades():
	gui_visible = !gui_visible
	get_tree().paused = gui_visible
	upgrades.visible = gui_visible

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "special":
		Global.play_special = true
	if anim_name == "fireball":
		Global.play_fireball = true


func _on_button_pressed() -> void:
	Global.spell_damage += 5
	display_upgrades()

func _on_button_2_pressed() -> void:
	animation.speed_scale += 0.1
	display_upgrades()


func _on_button_3_pressed() -> void:
	Global.player_speed += 5
	display_upgrades()
