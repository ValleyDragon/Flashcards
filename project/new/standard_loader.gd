extends Control

@onready var card = $Card/VBoxContainer/Flashcard

var flashcards = []
var weights = PackedFloat32Array([])
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	var flashcards = load_flashcards("res://flashcards/test.yaml")

func load_flashcards(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	var yaml_data = YAML.parse(content).get_data()
	var converted = convert_flashcards(yaml_data)
	return converted

func convert_flashcards(raw:Dictionary) -> Array:
	var included_flashcard_types = raw["cards"].keys()
	var converted = []
	for type in included_flashcard_types:
		var cards = raw["cards"][type]
		for card in cards:
			converted.append({"type": type, "data": card})
	return converted

func new_card(correct: bool) -> void: 
	var next_card = flashcards.pick_random()

func _on_wrong_pressed() -> void: new_card(false)
func _on_right_pressed() -> void: new_card(true)
