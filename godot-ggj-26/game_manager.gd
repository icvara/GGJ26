extends Node3D

@export var player_mangement : Node3D
@export var HUD : CanvasLayer
#@export var BaseCamp: Node3D


var time = 0
var end_of_time = 50

func _ready() -> void:
	
	player_mangement.newplayer_join.connect(HUD._on_player_update)
	#BaseCamp.max_storage_reach.connect(HUD._on_max_storage)
	HUD.get_node("ProgressBar").max_value = end_of_time


func _process(delta: float) -> void:
	time += delta
	HUD.update_time(time)
	if time > end_of_time:
		call_round_end()
	
func call_round_end():
	HUD._on_max_storage()
