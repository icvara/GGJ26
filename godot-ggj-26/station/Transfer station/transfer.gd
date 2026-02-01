extends Node3D

var item_in_A : Node3D
var item_in_B : Node3D

@export var isActive = true

func Transfer():
	if isActive:
		$SprayCan.play()
		await get_tree().create_timer(0.5).timeout
		if item_in_A:
			item_in_A.global_position = $posB.global_position
			item_in_A = null
		if item_in_B:
			item_in_B.global_position = $posA.global_position
			item_in_B = null




func put_item_in(item,TID):
	if isActive:

		if TID =="A":
			if item_in_A == null:
				item_in_A = item
		if TID =="B":
			if item_in_B == null:
				item_in_B = item
		Transfer()
		
