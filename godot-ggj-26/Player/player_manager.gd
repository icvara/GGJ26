extends Node3D

@export var player_scene : PackedScene

func _physics_process(delta: float) -> void:

	if Input.is_joy_button_pressed(0, 0):
		invoke_player(0)
	if Input.is_joy_button_pressed(1, 0):
		invoke_player(1)
	if Input.is_joy_button_pressed(2, 0):
		invoke_player(2)
	if Input.is_joy_button_pressed(3, 0):
		invoke_player(3)
		
		
func invoke_player(ID):
	var newplayer = player_scene.instantiate()
	newplayer.playerID = ID
	add_child(newplayer)
