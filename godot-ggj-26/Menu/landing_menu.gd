extends Node2D



func _on_button_play_pressed() -> void:
	get_tree().change_scene_to_file("res://main_game.tscn")


func _on_button_settings_pressed() -> void:
	pass # Replace with function body.
	#get_tree().change_scene_to_file(“res://apartment stairway.tscn”)

func _on_button_credit_pressed() -> void:
	pass # Replace with function body.
	#get_tree().change_scene_to_file(“res://apartment stairway.tscn”)

func _on_button_quit_pressed() -> void:
	get_tree().quit()


func _on_button_playclient_pressed() -> void:
	get_tree().change_scene_to_file("res://online/main_online.tscn")


func _on_button_host_pressed() -> void:
	GlobalParameter.ishosting = true
	get_tree().change_scene_to_file("res://online/main_online.tscn")
