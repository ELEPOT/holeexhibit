extends Node2D

func _on_screen_exited() -> void:
	get_tree().reload_current_scene()
