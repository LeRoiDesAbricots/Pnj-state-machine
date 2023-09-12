extends CharacterBody2D

func _on_area_2d_body_entered(body) -> void:
	if !body is Pnj:
		return
	if body.state_machine.state.name == "Calm":
		body.state_machine.transitioned_to("Shooting")
