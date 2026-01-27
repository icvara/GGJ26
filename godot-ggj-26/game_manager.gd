extends Node3D

@export var player_mangement : Node3D
@export var HUD : CanvasLayer


func _ready() -> void:
	
	player_mangement.newplayer_join.connect(HUD._on_player_update)
	
	
