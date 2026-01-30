extends Node3D

var probability = 0.5
var infection_state = 0
var max_infection = 10
var late_state_infection = 8


var player: Node3D


func _process(delta: float) -> void:
	if player:
		if !player.isDead:
			infection_state += delta
			
			if infection_state > late_state_infection:
				progress_infection()
				if infection_state > max_infection:
					player.Die()


func infect_player(p):
		player = p
		


func progress_infection():
	var mesh := player.get_node("MeshInstance3D")
	var mat = mesh.get_active_material(0)
	mat = mat.duplicate()
	mesh.set_surface_override_material(0, mat)
	mat.albedo_color.g = 1
	mat.albedo_color.r = 0.2
	mat.albedo_color.b = 0.2
