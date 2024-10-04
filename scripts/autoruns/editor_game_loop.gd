extends Node


func _ready() -> void:
	if OS.has_feature("editor"):
		OS.create_process("C:/Program Files/AutoHotkey/v2/AutoHotkey.exe", ["C:/Tools/autohotkey/switch_window_monitor.ahk"])
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST && OS.has_feature("editor"):
		OS.create_process("C:/Program Files/AutoHotkey/v2/AutoHotkey.exe", ["C:/Tools/autohotkey/switch_window_monitor.ahk"])
		get_tree().quit()
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit") && OS.has_feature("editor"):
		OS.create_process("C:/Program Files/AutoHotkey/v2/AutoHotkey.exe", ["C:/Tools/autohotkey/switch_window_monitor.ahk"])
		get_tree().quit()
