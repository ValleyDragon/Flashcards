extends Control

@onready var card_types = {
	"text_to_text": $TextToText
}

var current_card_type = "text_to_text"

func _ready() -> void:
	$TextToText.build({"text":["This is the question", "This is the answer"]})

func _on_flip_card_pressed() -> void:
	card_types[current_card_type].flip()
