extends Panel

var capacity = 5

func _process(delta):
	$Label.text = str(Global.arrowCounter) + "/" + str(capacity)
	if Global.arrowCounter > capacity:
		capacity += 1
