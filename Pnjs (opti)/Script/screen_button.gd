extends Node2D

enum modes {NORMAL, EXPLODE}

var mode := modes.NORMAL

@onready var preload_explosion := preload("res://Scène/explosion.tscn")

func _physics_process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("normal_mode"):
		mode = modes.NORMAL
	elif Input.is_action_just_pressed("explode_mode"):
		mode = modes.EXPLODE
	
	if mode == modes.EXPLODE:
		Global.global_drag = true

func _input(event: InputEvent) -> void:
	if !event is InputEventScreenTouch:
		return
	if event.is_pressed() && mode == modes.EXPLODE:
		explode(event.position)

func explode(explosion_position: Vector2) -> void:
	var explosion = preload_explosion.instantiate()
	get_parent().get_parent().add_child(explosion)
	explosion.global_position = explosion_position
	
