extends StaticBody3D
class_name Station


@export var item_ID_in = "0"
#@export var item_ID_out = "nothing"
@export var item_scene_out : PackedScene

var item_in = null

func doTransfoStuff():
	item_in.queue_free()
	var ni = item_scene_out.instantiate()
	ni.set_as_transport()
	ni.global_position = $"Item emplacement".global_position
	item_in = ni
	get_tree().current_scene.add_child(ni)



func put_item_in(item):
	if item_in == null:
		if item.item_ID == item_ID_in:
			item.global_position = $"Item emplacement".global_position
			item.rotation = Vector3(0,0,0)
			#item.set_collision_layer_value(3,false)
			item_in = item
			doTransfoStuff()

func remove_item_in():
	if item_in:
		#item_in.set_collision_layer_value(3,true)
		item_in = null
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
