# Fait la transition entre les différentes state
class_name StateMachine
extends Node

# Signal émit plus bas quand on change de state
# (pourra sûrement nous aider plus tard)
signal transitionned(state_name)

var new_shake: Shake = Shake.new()
@export var Shake_decay_rate := 0.0
@export var Noise_shake_strength := 0.0

@export var initial_state := NodePath() # Permet de sélectionner dans l'inspecteur la state initiale

@onready var camera: Camera2D = get_tree().get_first_node_in_group("Camera")
@onready var state: State = get_node(initial_state) # On get la state initiale

func _ready() -> void:
	await owner.ready # Attendre que le parent soit chargé
	
	new_shake._ready()
	
	new_shake.camera = camera
	new_shake.Shake_decay_rate = Shake_decay_rate
	new_shake.Noise_shake_strength = Noise_shake_strength
	
	# Une boucle qui fait en sorte que chaque state reconnaisse la state machine
	for child in get_children():
		child.state_machine = self
	
	state.enter() # On entre dans la state initiale

func _physics_process(delta: float) -> void:
	#new_shake._process(delta)
	state.update(delta)

# Fonction qui permet de changer de state, avec la state cible et le message
func transitioned_to(target_state: String, msg := {}) -> void:
	
	if !has_node(target_state): # Évite des bugs
		return
	
	# On change la state
	state.exit()
	state = get_node(target_state)
	state.enter(msg)
	emit_signal("transitionned", state.name) # Signal émis
