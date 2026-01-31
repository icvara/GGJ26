extends Node3D

@export var rooms: Array[PackedScene]
var room_size = 14

var current_time =0
var next_fog = 5.0
var fog_activation_time = 10.0
var current_fog_activation_time = 0.0



var count = 0
var rotation_list = [90*3,90*4,90*2,90*1]
func _enter_tree() -> void:
	for i in [0,1]:
			var j = 1
		#for j in [0,1]:
			 

			var nr = rooms[i].instantiate()
			nr.position = Vector3(i*room_size,0,j*room_size)
			#nr.get_node("Label3D").text = str(count)
			#nr.rotation.y =deg_to_rad(rotation_list[count])
			count += 1
			add_child(nr)

func _process(delta: float) -> void:
	current_time += delta
	if current_time >= next_fog:
		current_fog_activation_time += delta
		$infection_fog.position.y = clamp($infection_fog.position.y+ 0.05,-0.5,1)
		if current_fog_activation_time >= fog_activation_time:
			current_fog_activation_time=0
			release_fog()
			current_time = 0
			next_fog = randf_range(5,8)
	
func release_fog():
	var rnd_1 = randi_range(0,1)
	var rnd_j = 1# randi_range(0,1)
	$infection_fog.position = Vector3(rnd_1*room_size,-0.5,rnd_j*room_size)
