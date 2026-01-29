extends Node3D

@export var items: Array[PackedScene]
@export var grid_size := Vector3i(5, 1, 5) # grid width, height, depth
@export var cell_size := 2.0                 # size of each grid cell

func _on_timer_timeout():
	if items.is_empty():
		return

	# Pick random item
	var item_scene: PackedScene = items.pick_random()
	var item: Node3D = item_scene.instantiate()

	# Pick random grid coordinates
	var grid_x := randi_range(-grid_size.x, grid_size.x - 1)
	var grid_y := randi_range(-grid_size.y , grid_size.y - 1)
	var grid_z := randi_range(-grid_size.z, grid_size.z - 1)

	# Convert grid position to world position
	var world_pos := Vector3(
		grid_x * cell_size,
		grid_y * cell_size,
		grid_z * cell_size
	)

	item.position = world_pos
	add_child(item)
