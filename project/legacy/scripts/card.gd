extends CanvasLayer

enum FlashcardType { LATIN, SITELEN, BOTH }
@onready var latincard = $VBoxContainer/LatinCard
@onready var sitelenponacard = $VBoxContainer/SitelenPonaCard
@onready var sitelenlatincard = $VBoxContainer/SitelenLatinCard

@export var word = "toki"
@export var type: FlashcardType = FlashcardType.BOTH
@export var front = true
var definitions

func _ready() -> void:
	var file = FileAccess.open("res://legacy/assets/tokipona-definitions.json", FileAccess.READ)
	definitions = JSON.parse_string(file.get_as_text())
	
	refresh_display()
	
func _process(delta: float) -> void:
	pass

func refresh_display():
	set_flashcard_type(type)
	print(definitions[word])
	$VBoxContainer/LatinCard/Text.text = word
	$VBoxContainer/SitelenLatinCard/Text.text = word
	$VBoxContainer/SitelenLatinCard/SitelenPona.text = word
	$VBoxContainer/SitelenPonaCard/SitelenPona.text = word
	$VBoxContainer/AnswerCard/SitelenPona.text = word
	$VBoxContainer/AnswerCard/Text.text = word
	$VBoxContainer/AnswerCard/Meaning.text = definitions[word]

func set_flashcard_type(t: FlashcardType):
	type = t
	latincard.hide(); sitelenponacard.hide(); sitelenlatincard.hide(); $VBoxContainer/AnswerCard.hide()
	if front:
		$VBoxContainer/SideIndicator.text = "Question:"
		match t:
			FlashcardType.LATIN: latincard.show()
			FlashcardType.SITELEN: sitelenponacard.show()
			FlashcardType.BOTH: sitelenlatincard.show()
	else:
		$VBoxContainer/AnswerCard.show()
		$VBoxContainer/SideIndicator.text = "Answer:"
		

func set_word(w: String): word = w
