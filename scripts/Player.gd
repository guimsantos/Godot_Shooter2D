extends KinematicBody2D
class_name Player

var Arrow = preload("res://scenes/Arrow.tscn")
onready var bowAnim = $Node2D/bow


# Valores de movimentação
export (int) var speed = 200
export (int) var jump_speed = -300
export (int) var gravity = 650
export (float, 0, 1.0) var friction = 0.20
export (float, 0, 1.0) var acceleration = 0.25
var velocity = Vector2.ZERO
var airJumps = 1

func _process(delta):
	
	if Global.life == 0:
		queue_free()


# Entrada de Input
func get_input():
	
	# Shoot Arrow
	if Global.arrowCounter > 0 and Input.is_action_just_released("shoot"):
		Global.arrowCounter -= 1
		shoot()

	# Moviment
	var dir = 0
	if Input.is_action_pressed("right"):
		dir += 1
	if Input.is_action_pressed("left"):
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)


func _physics_process(delta):
	get_input()
	
# MOVIMENTAÇÃO DO PLAYER
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	# Pulo
	if Input.is_action_just_pressed("up"):
		if is_on_floor() or airJumps > 0:
			velocity.y = jump_speed
			airJumps -= 1
	if is_on_floor():
		airJumps = 1

# Faz o personagem dar cambalhota o imbecil
func shoot():
	""" Atira flecha a partir da posição do arco"""
	var a = Arrow.instance()
	owner.add_child(a)
	a = a.get_node("RigidBody2D")
	a.transform = $Node2D/bow/muzzle.get_global_transform()
	a.linear_velocity = a.transform.x * 350


func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		Global.life -= 1
