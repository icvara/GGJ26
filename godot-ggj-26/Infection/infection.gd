extends Node3D

var probability = 0.5
var infection_state = 0
var max_infection = 10
var late_state_infection = 8
@export var infect_scene: PackedScene


var player: Node3D


func _process(delta: float) -> void:
	if player:
		if !player.isDead:
			infection_state += delta
			
			if infection_state > late_state_infection:
				progress_infection()
				if infection_state > max_infection:
					finalise_infection()

func infect_player(p):
		player = p
		
func finalise_infection():
	var new_infect = infect_scene.instantiate()
	get_parent().get_parent().add_child(new_infect)
	new_infect.global_position = get_parent().global_position
	new_infect.global_position.y = 0.5
	new_infect.global_position.x += 1.

	player.Die()


func progress_infection():
	var mesh := player.get_node("MeshInstance3D")
	var mat = mesh.get_active_material(0)
	mat = mat.duplicate()
	mesh.set_surface_override_material(0, mat)
	mat.albedo_color.g = 1
	mat.albedo_color.r = 0.2
	mat.albedo_color.b = 0.2
