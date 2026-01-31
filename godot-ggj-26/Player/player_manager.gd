extends Node3D

@export var player_scene : PackedScene
@export var infection : PackedScene
@export var HUD : Node

signal newplayer_join(id)

var player_status = [0,0,0,0]
var infection_rate_at_spawn = 0.5
var position_list = [Vector3(5,0,5),Vector3(5+14,0,5-14),Vector3(5,0,5-14),Vector3(5+14,0,5)]
func _ready() -> void:
	for i in range(4):
		invoke_player(i, position_list[i])
		
		
#func _physics_process(delta: float) -> void:
	#if GlobalParameter.ishosting:
	'if Input.is_action_pressed("join_game"):
		print("pressed")
		#invoke_player.rpc_id(1,3)
		invoke_player(3)'


	'if Input.is_joy_button_pressed(0, 0):
		#invoke_player.rpc_id(1,0)
		invoke_player(0)

	if Input.is_joy_button_pressed(1, 0):
		#invoke_player.rpc_id(1,1)
		invoke_player(1)

	if Input.is_joy_button_pressed(2, 0):
		#invoke_player.rpc_id(1,2)
		invoke_player(2)

	if Input.is_joy_button_pressed(3, 0):
		#invoke_player.rpc_id(1,3)
		invoke_player(3)'

		

func infect_player_manager(p):
	if randf() < infection_rate_at_spawn:
		var newinfection = infection.instantiate()
		newinfection.infect_player(p)
		newinfection.name = "infection"
		p.add_child(newinfection)

@rpc("any_peer","call_local")	
func invoke_player(ID,pos):
	print(ID)
	if player_status[ID] == 0:
		player_status[ID] = 1
		var newplayer = player_scene.instantiate()
		newplayer.position = pos
		newplayer.name = str(multiplayer.get_unique_id())
		newplayer.playerID = ID
		newplayer.player_has_died.connect(_on_player_death)
		newplayer.maskchanged.connect(HUD._on_mask_update)
		add_child(newplayer)
		#infect_player_manager(newplayer)
		newplayer_join.emit(ID)


func _on_player_death(id):
	player_status[id] = 0
