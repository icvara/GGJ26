extends StaticBody3D


var item_stored = 0
var max_item = 100

signal max_storage_reach
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_text()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("players"):
		if body.item_collected > 0:
			item_stored += body.item_collected 
			body.item_collected = 0
			update_text()
			if item_stored > max_item:
				max_storage_reach.emit()
			
func update_text():
	$Label3D.text = str(item_stored) + "/" + str(max_item) + " Collected"
	
	
