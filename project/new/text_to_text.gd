extends VBoxContainer

var randomise = false # doesn't work
var mode = Mode.QUESTION

func build(info: Dictionary) -> void:
	var text1 = info["text"][0]
	var text2 = info["text"][1]
	$text1.text = text1 # orgignally question
	$text2.text = text2 # originally answer
	$text1.show()
	$text2.hide()


func flip() -> void:
	if mode == Mode.QUESTION:
		mode = Mode.ANSWER
		$text1.hide()
		$text2.show()
	else:
		mode = Mode.QUESTION
		$text1.show()
		$text2.hide()
	
