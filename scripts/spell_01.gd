extends Node2D


@onready var animation = $AnimatedSprite2D
@onready var timer = $Life
const SPEED: float = 150.0
var dir :Vector2
var hit = false

func _ready() -> void:
	rotation = dir.angle()
	
func _process(delta: float) -> void:
	if hit != true:
		position += dir * SPEED * delta

func _on_timer_timeout() -> void:
	queue_free()

func _on_spell_body_entered(_body: Node2D) -> void:
	animation.play("hit")
	hit = true
	timer.stop()


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
