# Charge d'avance des fonctions qui seront utilisés par les autres states
class_name State
extends Node

var state_machine = null

# Agis comme _integrate_forces(state)
func rigidbody_process(_state: PhysicsDirectBodyState2D, _velocity: Vector2) -> void:
	pass

# Agis comme _process(delta)
func update(_delta: float) -> void:
	pass

# Quand on rentre dans une state, un message peut être émis pour communiquer entre les différentes states
func enter(_msg := {}) -> void:
	pass

# Quand on quitte une state
func exit() -> void:
	pass
