extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("players"):
		$Label3D_output.show()
		if body.has_node("infection"):
			$Label3D_output.text = str("Infected")
		else:
			$Label3D_output.text = str("Non Infected")
		await get_tree().create_timer(1).timeout
		$Label3D_output.hide()
