extends Control

@export var left = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if left == false:
		$ProgressBar2.hide()
	else:
		$ProgressBar.hide()

func update_progressbar(id,value):
	$ProgressBar.value = value
	$ProgressBar2.value = value
	print(value)
	print(id)
	if value > 0:
		print("mask")
		$picture.get_node(str(id)).show()
		$picture2.get_node(str(id)).hide()
	else:
		print("nomask")

		$picture2.get_node(str(id)).show()
		$picture.get_node(str(id)).hide()

func update_picture(id,masked):
	if masked:
		$picture.get_node(str(id)).show()
		$picture2.get_node(str(id)).hide()

	else:
		$picture2.get_node(str(id)).show()
		$picture.get_node(str(id)).hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
