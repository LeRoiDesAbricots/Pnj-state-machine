extends PnjState

@onready var escape_timer: Timer = $Escape_timer

var shake_count := 0
var max_shake := 3

func enter(_msg := {}) -> void:
	
	escape_timer.start()
	

func rigidbody_process(_s: PhysicsDirectBodyState2D, velocity: Vector2) -> void:
	
	if Input.is_action_just_released("Left_click"):
		state_machine.transitioned_to("Panic", {touched = true})
	else:
		# Empêche le bug du bounce trop excessif quand on force le pnj vers le sol
		pnj.physics_material_override.bounce = 0
		# Collide avec les autres et soit même
		pnj.set_collision_layer_value(2, true)
		
		var mouse_position := pnj.get_global_mouse_position()
		var direction_to_mouse := (mouse_position - pnj.global_position) # Calcule la distance entre la souris et le pnj
		
		pnj.apply_central_impulse(direction_to_mouse * 8 - velocity/2)

func _escape_timeout() -> void:
	state_machine.new_shake.apply_shake()
	shake_count += 1
	
	if shake_count >= max_shake:
		escape_timer.stop()
		shake_count -= shake_count
		state_machine.transitioned_to("Panic", {touched = true})

func exit() -> void:
	Global.global_drag = false
	escape_timer.stop()
