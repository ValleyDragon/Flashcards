extends Control

@onready var card_types = {
	"text_to_text": $TextToText
}

var current_card_type = "text_to_text"

func switch_to_card(card: Dictionary) -> void:
	current_card_type.hide() # hide the previous
	current_card_type = card["type"]
	card_types[current_card_type].show() 
	card_types[current_card_type].build(card["data"])

func _ready() -> void:
	$TextToText.build({"text":["This is the question", "This is the answer"]})

func _on_flip_card_pressed() -> void:
	card_types[current_card_type].flip()
