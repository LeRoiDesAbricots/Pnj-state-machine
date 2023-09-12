class_name Pnj
extends RigidBody2D

@export var initial_speed : float
var current_speed := 0

@onready var directions := [-initial_speed, 0, initial_speed]

@onready var state_machine: StateMachine = get_node("StateMachine")

@export var initial_sprite := NodePath()
@onready var sprite := get_node(initial_sprite)

func _ready() -> void:
	print(self.get_script())
	physics_material_override = physics_material_override.duplicate()
	physics_material_override.bounce = 0

func _integrate_forces(s: PhysicsDirectBodyState2D) -> void:
	var velocity := s.get_linear_velocity()
	state_machine.state.rigidbody_process(s, velocity)

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	
	if !event is InputEventScreenTouch:
		return
	if Input.is_action_pressed("Left_click") && !Global.global_drag:
		Global.global_drag = true
		state_machine.transitioned_to("Escaping")
