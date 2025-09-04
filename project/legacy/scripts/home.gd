extends CanvasLayer

var courses = ["pu", "toki pona app"]
var selected = 0
@onready var lessons = preload("res://legacy/assets/tokipona-flashcards.json")
var current_lessons
var lesson_selected = -1
var lesson_type = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Flashcards.hide_flashcards()
	
	lessons = lessons.get_data()
	current_lessons = lessons["pu"]
	update_course_showing()

func _process(delta: float) -> void:
	pass

func update_course_showing():
	lesson_selected = -1
	$VBoxContainer/LessonSelect.text = "-Select Lesson-"
	$VBoxContainer/HBoxContainer/CourseIndicator.text = courses[selected]
	if courses[selected] == "pu":
		$VBoxContainer/HBoxContainer/CourseIndicator.add_theme_font_override("font", load("res://assets/fonts/nasin-nanpa-4.0.1.otf"))
	else:
		$VBoxContainer/HBoxContainer/CourseIndicator.remove_theme_font_override("font")
		
	current_lessons = lessons[courses[selected]]
	$VBoxContainer/LessonSelect.get_popup().clear()
	for i in range(len(current_lessons)):
		$VBoxContainer/LessonSelect.get_popup().add_item(current_lessons.keys()[i], i)
	
	#$VBoxContainer/LessonSelect.get_popup().id_pressed.connect(_on_new_lesson_selected)
	#$VBoxContainer/LessonType.get_popup().id_pressed.connect(_on_new_lesson_type_selected)
	#

func _on_kama_pressed() -> void:
	selected -= 1
	if selected < 0: selected = len(courses)-1
	update_course_showing()

func _on_tawa_pressed() -> void:
	selected += 1
	if selected >= len(courses): selected = 0
	update_course_showing()

func _on_new_lesson_selected(id: int):
	print(id)
	lesson_selected = id
	$VBoxContainer/LessonSelect.text = current_lessons.keys()[id]

#func _on_new_lesson_type_selected(id: int):
	#lesson_type = id
	#var t = ""
	#match id:
		#0: t = "Learn All"
		#1: t = "Learn only Meanings"
		#2: t = "Learn only Sitelen Pona"
	#$VBoxContainer/LessonType.text = t


func _on_start_lesson_pressed() -> void:
	$Flashcards.lesson_type = $VBoxContainer/LessonType.selected
	if lesson_selected != -1:
		$Flashcards.show_flashcards()
		$VBoxContainer.hide()
		
		$Flashcards.words = current_lessons[current_lessons.keys()[lesson_selected]]
		$Flashcards.prepare_for_new_words()


func _on_flashcards_close() -> void:
	$Flashcards.hide_flashcards()
	$VBoxContainer.show()
