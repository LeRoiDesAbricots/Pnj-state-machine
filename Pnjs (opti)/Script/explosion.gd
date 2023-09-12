extends Node2D

@export var explosion_force: float
@export var explosion_radius := 10.0

@onready var collider_collision = $Collider/CollisionShape2D

func _ready() -> void:
	collider_collision.shape.radius = explosion_radius

func _on_life_timeout():
	queue_free()

func _on_collider_body_entered(body) -> void:
	if !body is Pnj:
		return
	else:
		var collision_point: Vector2 = -(global_position - body.global_position)
		var force_applied: float = abs(collision_point.distance_to(Vector2.ZERO) - collider_collision.shape.radius)
		var direction: Vector2 = Vector2.ZERO.direction_to(collision_point)
		body.state_machine.transitioned_to("Panic", {touched = true})
		body.apply_central_impulse(force_applied * direction * explosion_force)
