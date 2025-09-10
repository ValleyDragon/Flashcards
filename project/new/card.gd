extends Control

var flashcards = {
	"text_to_text": [
		{"text": ["question", "answer"]},
		{"text": ["question", "answer"]},
	]
}

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

func _ready() -> void:
	print(load_flashcards("res://flashcards/test.yaml"))
