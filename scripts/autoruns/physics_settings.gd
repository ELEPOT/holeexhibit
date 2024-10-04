extends Node


func _ready() -> void:
	Engine.max_physics_steps_per_frame = 64
	Engine.physics_ticks_per_second = 60 * Engine.max_physics_steps_per_frame / 8
	
