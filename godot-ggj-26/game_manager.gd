extends Node3D

@export var player_mangement : Node3D
@export var HUD : CanvasLayer
@export var BaseCamp: Node3D

func _ready() -> void:
	
	player_mangement.newplayer_join.connect(HUD._on_player_update)
	BaseCamp.max_storage_reach.connect(HUD._on_max_storage)
	
