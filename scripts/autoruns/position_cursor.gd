extends Node


@export var sensitivity: float = 1.0

var position: Vector2

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseMotion):
		position += event.relative * sensitivity
