extends CanvasLayer

func _process(delta: float) -> void:
	$Label.text = "Mask built: " + str(GlobalParameter.maskcount)


func _ready() -> void:
	$"Player_HUD1/picture/0".show()
	$"Player_HUD4/picture/1".show()


func update_time(value):
	$ProgressBar.value = value


func _on_mask_update(playerID, value):
	get_node("Player_HUD" +str(playerID+1)).update_progressbar(value)



func _on_player_update(id):
	pass
	'print("player " + str(id) + " joined")
	if id == 0:
		$HBoxContainer/Player_HUD/Panel/Label.text = "Player" + str(id) 
	if id == 1:
		$HBoxContainer/Player_HUD2/Panel/Label.text = "Player" + str(id) 
	if id == 2:
		$HBoxContainer/Player_HUD3/Panel/Label.text = "Player" + str(id) 
	if id == 3:
		$HBoxContainer/Player_HUD4/Panel/Label.text = "Player" + str(id) '
		
		
func _on_max_storage():
	pass
	#$win_window.show()

func _on_death(id):
	get_parent().get_node("Loop01").stop()
	await get_tree().create_timer(2).timeout
	$MaskLost.play()
	$gameover_window.show()


func _on_button_pressed() -> void:
	GlobalParameter.maskcount = 0
	get_tree().reload_current_scene()


func _on_button_3_pressed() -> void:
	GlobalParameter.maskcount = 0
	get_tree().change_scene_to_file("res://Menu/Landing_menu.tscn")
