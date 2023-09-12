extends PnjState

@onready var direction_timer := $Timer_direction

var direction := Vector2.ZERO

func enter(_msg := {}) -> void:
	direction_timer.start()
	change_direction()

# Agis comme integrate_forces()
func rigidbody_process(_s: PhysicsDirectBodyState2D, velocity: Vector2) -> void:
	
	if !sign(pnj.current_speed) == 0:
		pnj.sprite.flip_h = bool(sign(pnj.current_speed) + 1) # Change le flip du pnj par rapport à sa direction
	
	# Faire avancer le pnj vers la direction
	direction = Vector2(pnj.current_speed, 0)
	pnj.apply_central_impulse(direction * 8 - velocity/2) # Meilleure façon avec un RigidBody2D

# Change la direction du pnj
func change_direction() -> void:
	var possibility = randi() % pnj.directions.size() # Choisi un chiffre random entre 1 et 3
	pnj.current_speed = pnj.directions[possibility] # Assigne ce chiffre à l'Array

# Changer le temps du timer pour plus d'aléatoire
func change_timer_wait_time() -> void:
	direction_timer.wait_time = randf_range(0.5, 2)

# Timer qui sert à faire changer la direction
func _on_timer_direction_timeout() -> void:
	change_timer_wait_time()
	change_direction()
