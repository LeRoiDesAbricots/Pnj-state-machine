extends Pnj

@onready var animation_player = $AnimationPlayer

func _physics_process(_delta: float) -> void:
	
	var velocity = linear_velocity
	
	if state_machine.state.name == "Panic" || state_machine.state.name == "Escaping":
		animation_player.play("Panic_agent1")
		
	elif state_machine.state.name == "Calm":
		if is_equal_approx(velocity.x, 0.0):
			animation_player.play("Idle_agent1")
		else:
			animation_player.play("Run_agent1")
