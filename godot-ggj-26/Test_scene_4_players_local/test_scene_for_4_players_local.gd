extends Node2D
@export var player_scene: PackedScene

func _process(delta: float) -> void:
	pass


func _input(event):
	if event is InputEventJoypadButton and event.pressed:
		print("Button from device:", event.device)



func spawn_players():
	var controllers := Input.get_connected_joypads()
	for i in controllers.size():
		var player = player_scene.instantiate()
		player.device_id = controllers[i]
		add_child(player)
