extends Control

@export var soundtrack_config: SoundtrackConfig


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		Soundtrack.change_config(soundtrack_config)

func _ready() -> void:
	AudioServer.set_bus_volume_linear(1, 1.0)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/gym.tscn")


func _on_fullscreen_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
