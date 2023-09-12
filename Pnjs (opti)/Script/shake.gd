class_name Shake
extends Node2D

@onready var camera: Camera2D
@onready var rand := RandomNumberGenerator.new()

var noise = FastNoiseLite.new()

var Shake_decay_rate := 0.0
var Noise_shake_strength := 0.0
var noise_i := 0.0
var shake_strength := 0.0
var shake_count := 0

func _ready() -> void:
	
	rand.randomize()
	
	noise.seed = rand.randi()
	noise.fractal_octaves = 2
	

func _process(delta: float) -> void:
	
	shake_strength = lerp(shake_strength, 0.0, Shake_decay_rate * delta)
	
	camera.offset = get_noise_offset(delta)
	

func apply_shake() -> void:
	
	shake_strength = Noise_shake_strength
	shake_count += 1

func get_noise_offset(delta: float) -> Vector2:
	noise_i += delta * Noise_shake_strength
	
	return Vector2(
		noise.get_noise_2d(1, noise_i) * shake_strength,
		noise.get_noise_2d(100, noise_i) * shake_strength
	)

func get_random_offset() -> Vector2:
	return Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)
