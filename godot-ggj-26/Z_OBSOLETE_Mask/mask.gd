extends CharacterBody3D

var isequipped = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if !isequipped:
		if body.is_in_group("players"):
			if body.mask_equipped == null:
				body.put_on_mask(self)
