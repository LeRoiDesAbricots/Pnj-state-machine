extends PnjState

enum panic_states {TOUCHED, COLLISION, ENVIRONNMENT}

var panic_state := panic_states.TOUCHED

func enter(msg := {}) -> void:
	if msg.has("touched"):
		
		pnj.set_deferred("lock_rotation", false)
		# Enlève la collision quand n'est plus dragged
		pnj.set_collision_layer_value(2, false)
		# Remet le bounce parce que fun :)
		pnj.physics_material_override.bounce = 1
		
		panic_state = panic_states.TOUCHED
		
	elif msg.has("collision"):
		panic_state = panic_states.COLLISION
	elif msg.has("environnment"):
		# Je me suis dis que de faire un mode où le pnj panique par ce qui se passe dans l'environnement
		# était une bonne idée, mais pour l'instance, le panic_state sert juste à essayer une autre façon
		# de représenter l'état d'un pnj que par une variable booléenne, cette fois-ci, on prend une
		# énumération et une variable qui sert à switch entre les deux états: "TOUCHED" qui agis quand
		# la panic se crée du à la souris ou à la collision avec un pnj dragged et "ENVIRONNMENT" que l'on
		# pourrait expérimenter plus tard
		panic_state = panic_states.ENVIRONNMENT
	

func rigidbody_process(_s: PhysicsDirectBodyState2D, _velocity: Vector2) -> void:
	
	if panic_state == panic_states.COLLISION:
		
		pnj.physics_material_override.bounce = 0
		pnj.set_collision_layer_value(2, true)


func _on_pnj_body_entered(body) -> void:
	
	if !body is Pnj:
		return
	
	# Permet de faire paniquer les autres pnjs quand on les touches
	
	var state_name: Node = body.state_machine.state
	
	if state_name.name == "Panic":
		body.state_machine.state.panic_state = body.state_machine.state.panic_states.COLLISION
	elif state_name.name != "Escaping":
		body.state_machine.transitioned_to("Panic", {collision = true})
	
