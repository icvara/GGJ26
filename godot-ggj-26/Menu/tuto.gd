extends Node3D

var fogIn = false
var next = false
#@export var player_mangement : Node3D
@export var HUD : CanvasLayer
#@export var BaseCamp: Node3D

var step = 0

var time = 0
var end_of_time = 50

func _ready() -> void:
	$Player.playerID = 0
	$Player.maskchanged.connect(HUD._on_mask_update)
	$Player2.playerID = 3
	$Player2.maskchanged.connect(HUD._on_mask_update)

	HUD.get_node("ProgressBar").max_value = end_of_time
	$CanvasLayer/Panel/Label.show()
	$RoomA.get_node("Fog").players_in_rooms.append($Player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("join_game"):
		print("enter")
		print(step)

		next = true
		
	if $Player.item_hold:
		if $Player.item_hold.item_ID == "mask":
			$CanvasLayer/Panel/Label.text = "Well Done! , Now hold SPACE to equip it"
	
	if $Player.mask_equipped and fogIn ==false:
			fogIn = true
			$CanvasLayer/Panel/Label.text = "Just in time.. the fog is there"
			$RoomA.get_node("Fog").Activate() 
			$HUD/Player_HUD4.hide()
			$HUD/Label.hide()
			$HUD.show()
			await get_tree().create_timer(6).timeout
			$CanvasLayer/Panel/Label.text = "Well Done, you survived. \nBut take care your mask is endommaged"


			$CanvasLayer/Panel/Label3.show()
			step = 1
			next = false
	if next == true and step == 1:
				step = 2
				next = false
				print("hello")
				$CanvasLayer/Panel/Label.text = "Well Done, you survived. \nBut take care your mask is endommaged \nYou will need to build a new one soonish or you will die"
	if next == true and step == 2:
				$RoomA.get_node("item1").show() 
				$RoomA.get_node("item1").set_collision_layer_value(3, true)
				$RoomA.get_node("item1").freeze = false
				$CanvasLayer/Panel/Label.text = "Assemble a new mask! Start by putting the yellow thing into the yellow box"
				$CanvasLayer/Panel/Label3.hide()
				next = false
				step += 1



	if $RoomA/Station_transform.item_in and step ==3:
		$CanvasLayer/Panel/Label.text = "Well Done, now it is green"
		$CanvasLayer/Panel/Label3.show()
		step +=1

	if next == true and step == 4:
			next = false
			step +=1

			$CanvasLayer/Panel/Label.text = "You will need some help for the next step!"
			$RoomB.show()
			$RoomA/Transfer.isActive = true
			$Player2.show()
	if next == true and step ==5:
			step += 1
			next = false
			$CanvasLayer/Panel/Label.text = "Use Key Arrow to move your friends and Shift to interact\n Or press Q or E to change control"
	if next == true and step == 6:
			step += 1
			$CanvasLayer/Panel/Label.text = "Now Try to make a new mask. Use the vent in middle to exchange object"
			$CanvasLayer/Panel/Label3.hide()
			next = false

	if GlobalParameter.maskcount > 0 and step == 7:
		$CanvasLayer/Panel/Label.text = "Congratulations!"
		$CanvasLayer/Panel/Label3.show()

		$CanvasLayer/Panel/Label3.text = "[Enter to Start the Game]"
		step += 1
		next = false

	if next == true and step == 8:
		get_tree().change_scene_to_file("res://main_game.tscn")
