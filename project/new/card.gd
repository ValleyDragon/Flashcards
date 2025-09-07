extends Control

var flashcards = {
	"text_to_text": [
		{"text": ["question", "answer"]},
		{"text": ["question", "answer"]},
	]
}

func convert_flashcards(raw:Dictionary) -> Array:
	var included_flashcard_types = raw.keys()
	var converted = []
	for type in included_flashcard_types:
		var cards = raw[type]
		for card in cards:
			converted.append({"type": type, "data": card})
	return converted

func _ready() -> void:
	print(convert_flashcards(flashcards))
