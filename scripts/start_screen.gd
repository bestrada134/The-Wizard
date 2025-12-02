extends Control
@onready var label = $RichTextLabel
@onready var http = $HTTPRequest

var url = "https://uselessfacts.jsph.pl/api/v2/facts/random"

func _ready() -> void:
	http.request(url)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_upgrades_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/upgrades.tscn")


func _on_http_request_request_completed(_result: int, _response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	var data = JSON.parse_string(body.get_string_from_utf8())
	print(data.text)
	label.text = "DID YOU KNOW: \n" + str(data.text)
