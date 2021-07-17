extends Node2D

var pickable = false
var lastPosition
var hit = 1


func _process(delta):
	$RigidBody2D.rotation = $RigidBody2D.linear_velocity.angle()
	$Area2D.transform = $RigidBody2D.transform
	if $RigidBody2D.linear_velocity == Vector2.ZERO:
		hit = 0
	

func stick_ground():
	pass

func _on_Timer_timeout():
	pickable = true

func _on_Area2D_body_entered(body):
	if $RigidBody2D.linear_velocity <= Vector2(15.0,15.0):
		if pickable and body.is_in_group("Player"):
			Global.arrowCounter += 1
			queue_free()
	if hit > 0:
		if body.is_in_group("enemy"):
			hit -= 1
			body.queue_free()
			$RigidBody2D.linear_velocity.x = 0
