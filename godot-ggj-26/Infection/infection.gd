extends Node3D

var probability = 0.5
var infection_state = 0
var max_infection = 5

var player: Node3D


func _process(delta: float) -> void:
	if player:
		if !player.isDead:
			infection_state += delta
			progress_infection()
			if infection_state > max_infection:
				player.Die()


func infect_player(p):
		player = p
		var mesh := player.get_node("MeshInstance3D")
		var mat = mesh.get_active_material(0)
		mat.albedo_color.g = 0


func progress_infection():
	var mesh := player.get_node("MeshInstance3D")
	var mat = mesh.get_active_material(0)
	mat.albedo_color.g += 0.1
