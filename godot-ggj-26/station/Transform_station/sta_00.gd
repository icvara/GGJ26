extends Station

var next = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func doTransfoStuff():
	#item_in.queue_free()
	var ni = item_scene_out.instantiate()
	#ni.set_as_transport()
	ni.global_position = $"Item emplacement".global_position
	get_tree().current_scene.add_child(ni)
	$Random1.play()


func put_item_in(item):
	pass


func remove_item_in():
	print("hellow")
	doTransfoStuff()
