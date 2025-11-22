extends Area2D


const SPEED: float = 100.0
var dir :Vector2

func _ready() -> void:
	rotation = dir.angle()
	
func _process(delta: float) -> void:
	position += dir * SPEED * delta

func _on_timer_timeout() -> void:
	queue_free()
