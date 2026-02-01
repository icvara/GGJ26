extends Node3D

@export var rooms: Array[PackedScene]
var room_size = 14

var current_time =0
var next_fog = 15.0
var fog_activation_time = 5.0
var current_fog_activation_time = 0.0

var round_count = 0
var rooms_array = []

var count = 0
var rotation_list = [90*3,90*4,90*2,90*1]
func _enter_tree() -> void:
	for i in [0,1]:
			var j = 1
		#for j in [0,1]:
			 

			var nr = rooms[i].instantiate()
			nr.position = Vector3(i*room_size,0,j*room_size)
			rooms_array.append(nr)
			#nr.get_node("Label3D").text = str(count)
			#nr.rotation.y =deg_to_rad(rotation_list[count])
			count += 1
			add_child(nr)

func _process(delta: float) -> void:
	current_time += delta
	if current_time >= next_fog:
		var n = randi_range(0,1)
		rooms_array[n].get_node("Fog").Activate() 
		current_time = 0
		#release_fog2(n,delta)
		next_fog = clamp(randf_range(25,35) - round_count,8,35)
		round_count += 4

		#current_fog_activation_time += delta
		#$infection_fog.position.y = clamp($infection_fog.position.y+ 0.05,-0.5,1)
		#if current_fog_activation_time >= fog_activation_time:
			#current_fog_activation_time=0
			#release_fog()
		



func release_fog():
	var rnd_1 = randi_range(0,1)
	var rnd_j = 1# randi_range(0,1)
	$infection_fog.position = Vector3(rnd_1*room_size,-0.5,rnd_j*room_size)
