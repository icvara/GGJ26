extends Node2D



func _on_button_play_pressed() -> void:
	$Random3.play()

	get_tree().change_scene_to_file("res://main_game.tscn")


func _on_button_settings_pressed() -> void:
	pass # Replace with function body.
	#get_tree().change_scene_to_file(“res://apartment stairway.tscn”)

func _on_button_credit_pressed() -> void:
	pass # Replace with function body.
	#get_tree().change_scene_to_file(“res://apartment stairway.tscn”)

func _on_button_quit_pressed() -> void:
	$Random3.play()
	await get_tree().create_timer(0.3).timeout
	get_tree().quit()


func _on_button_playclient_pressed() -> void:
	$Random3.play()
	
	get_tree().change_scene_to_file("res://online/main_online.tscn")


func _on_button_host_pressed() -> void:
	GlobalParameter.ishosting = true
	get_tree().change_scene_to_file("res://online/main_online.tscn")


func _on_button_play_2_pressed() -> void:
	$Random3.play()
	$personnage.show()


func _on_button_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/tuto.tscn")


func _on_texture_button_pressed() -> void:
	$MenuUiBackgroundState1.hide()
	$MenuUiBackground2.show()
