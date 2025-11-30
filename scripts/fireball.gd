extends Area2D

@onready var aoe = $AoE
@onready var animation = $AnimatedSprite2D
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

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()


func _on_area_entered(_area: Area2D) -> void:
	aoe.set_deferred("monitorable", true)
	animation.play("hit")
	hit = true
