extends Node3D

@export var player_scene : PackedScene
@export var infection : PackedScene

signal newplayer_join(id)

var player_status = [0,0,0,0]

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("join_game"):
		invoke_player(3)


	if Input.is_joy_button_pressed(0, 0):
		invoke_player.rpc_id(1,0)

	if Input.is_joy_button_pressed(1, 0):
		invoke_player.rpc_id(1,1)
	if Input.is_joy_button_pressed(2, 0):
		invoke_player.rpc_id(1,2)
	if Input.is_joy_button_pressed(3, 0):
		invoke_player.rpc_id(1,3)
		

func infect_player_manager(p):
	var newinfection = infection.instantiate()
	if newinfection.infect_player(p):
		p.add_child(newinfection)

@rpc("any_peer","call_local")	
func invoke_player(ID):
	print(ID)
	if player_status[ID] == 0:
		player_status[ID] = 1
		var newplayer = player_scene.instantiate()
		newplayer.name = str(multiplayer.get_unique_id())
		newplayer.playerID = ID
		newplayer.player_has_died.connect(_on_player_death)
		add_child(newplayer)
		infect_player_manager(newplayer)
		newplayer_join.emit(ID)


func _on_player_death(id):
	player_status[id] = 0
