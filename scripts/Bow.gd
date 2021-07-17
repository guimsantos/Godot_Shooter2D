extends Node2D


onready var bowAnim = $bow
onready var daggerAnim = $dagger

func _process(delta):
	look_at(get_global_mouse_position())
	
	# Animação Arco
	if Global.arrowCounter > 0 and Input.is_action_pressed("shoot"):
		bowAnim.frame = 2
	if Global.arrowCounter > 0 and Input.is_action_just_released("shoot"):
		bowAnim.play("",true)

	# Animação Adaga
	if Input.is_action_just_pressed("melee attack"):
		bowAnim.hide()
		daggerAnim.show()
		daggerAnim.play()
	
	if rotation_degrees > 360:
		rotation_degrees = 0
	if rotation_degrees < 0:
		rotation_degrees = 360
	
	if (rotation_degrees <= 90 and rotation_degrees >=0) or (rotation_degrees >= 270 and rotation_degrees <= 360):
		daggerAnim.scale.y = 1
	else:
		daggerAnim.scale.y = -1

func _on_bow_animation_finished():
	bowAnim.stop()
	bowAnim.frame = 0
	
	
func _on_dagger_animation_finished():
	bowAnim.show()
	daggerAnim.stop()
	daggerAnim.hide()
