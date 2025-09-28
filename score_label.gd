extends Label

var score = 0

func _on_object_cleared():
	score += 100
	text = "Score: %s" % score
