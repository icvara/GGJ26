extends Control

@export var left = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if left == false:
		$ProgressBar2.hide()
	else:
		$ProgressBar.hide()

func update_progressbar(value):
	$ProgressBar.value = value
	$ProgressBar2.value = value

func update_picture(id):
	$picture.get_node(str(id)).show()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
