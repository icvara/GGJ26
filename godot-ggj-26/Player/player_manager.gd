extends Node3D

@export var player_scene : PackedScene

signal newplayer_join(id)

var player_status = [0,0,0,0]

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("join_game"):
		invoke_player(3)


	if Input.is_joy_button_pressed(0, 0):
		invoke_player(0)
	if Input.is_joy_button_pressed(1, 0):
		invoke_player(1)
	if Input.is_joy_button_pressed(2, 0):
		invoke_player(2)
	if Input.is_joy_button_pressed(3, 0):
		invoke_player(3)
		
		
func invoke_player(ID):
	if player_status[ID] == 0:
		player_status[ID] = 1
		var newplayer = player_scene.instantiate()
		newplayer.playerID = ID
		newplayer.player_has_died.connect(_on_player_death)
		add_child(newplayer)
		newplayer_join.emit(ID)


func _on_player_death(id):
	player_status[id] = 0
