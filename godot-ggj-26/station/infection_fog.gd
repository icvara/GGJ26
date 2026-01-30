extends Node3D


@export var infection_scene : PackedScene

var players_in_fog = []
var infection_rate = 0.5
var timer = 1


func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0:
		for p in players_in_fog:
			fog_infection_of_player(p)
		timer = randf_range(0.,2.) #Maybe do a curve random here
	pass


func fog_infection_of_player(p):
	if randf() < infection_rate:
		if !p.mask_equipped:
			var newinfection = infection_scene.instantiate()
			newinfection.infect_player(p)
			newinfection.name = "infection"
			p.add_child(newinfection)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("players"):
		players_in_fog.append(body)


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("players"):
		if players_in_fog.has(body):
			players_in_fog.erase(body)
