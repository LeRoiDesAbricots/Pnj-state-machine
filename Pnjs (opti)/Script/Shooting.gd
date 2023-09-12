extends PnjState

@onready var animation_player := get_node("../../AnimationPlayer")

func enter(_msg := {}) -> void:
	animation_player.play("Shoot_agent1")
