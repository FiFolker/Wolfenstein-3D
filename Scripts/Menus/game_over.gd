extends CanvasLayer




func _on_replay_button_down() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
	



func _on_quit_button_down() -> void:
	get_tree().quit()
