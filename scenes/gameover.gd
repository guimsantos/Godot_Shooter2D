extends Label


func _process(delta):
	
	if Global.life == 0:
		self.show()
