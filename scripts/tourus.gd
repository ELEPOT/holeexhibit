extends Node2D

@export var damp: float

@onready var outside: RigidBody2D = $Outside
@onready var inside: RigidBody2D = $Inside

func _on_screen_exited() -> void:
	get_tree().reload_current_scene()

func _physics_process(delta: float) -> void:
	inside.apply_force((outside.global_position - inside.global_position) * damp)
