extends Node3D

var brainowner : Node3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	brainowner = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if brainowner.IAcontrol:
		pass
		
		


func going_to(t):
	return ( t.global_position -global_position).normalized()
