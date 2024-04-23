extends TextureRect

signal lose_game

var life : int = 3

func _ready():
	update_life_text()

func lose_life():
	life -= 1
	update_life_text()
	if life <= 0:
		emit_signal("lose_game")

func gain_life():
	life += 1
	update_life_text()

func update_life_text():
	$LineEdit.editable = true
	if life < 10:
		$LineEdit.text = "0"
	else:
		$LineEdit.text = ""
	$LineEdit.text += str(life) + "x"
	$LineEdit.editable = false
