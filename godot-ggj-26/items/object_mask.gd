extends RigidBody3D

var value = 100
@export var  item_ID = "mask"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func put_back_in_world():
	freeze = false

func set_as_transport():
	linear_velocity = Vector3(0,0,0)
	freeze = true

	pass
