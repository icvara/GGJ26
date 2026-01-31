extends CanvasLayer


func update_time(value):
	$ProgressBar.value = value

func _on_player_update(id):
	print("player " + str(id) + " joined")
	if id == 0:
		$HBoxContainer/Player_HUD/Panel/Label.text = "Player" + str(id) 
	if id == 1:
		$HBoxContainer/Player_HUD2/Panel/Label.text = "Player" + str(id) 
	if id == 2:
		$HBoxContainer/Player_HUD3/Panel/Label.text = "Player" + str(id) 
	if id == 3:
		$HBoxContainer/Player_HUD4/Panel/Label.text = "Player" + str(id) 
		
		
func _on_max_storage():
	pass
	#$win_window.show()
