extends CharacterBody3D

@export var gravity: float = 100.0
var playerID = 0
var playerIDctrl = 0

var mask_equipped = null
var mask_timer_finished = true

var head_pos = Vector3(0.,1.,0.)
var item_collected = 0


var item_hold = null
var item_in_proximiy = []

var station_in_proximity = []

var isDead = false

var current_HP = 100
var max_HP = 100
var timer = 0

signal player_has_died(id)

var maxspeed = 15
var current_speed = 0
var acceleration = 100
@export var speed := 15.0
var IAcontrol = false


var holding = false
var hold_time = 0
var long_pressed = false
var LONG_PRESS_TIME = 0.6
signal maskchanged(ID, value)

func _ready() -> void:
	current_HP = max_HP
	$DebugLabel.text = str(current_HP)
	$Label3D_playername.text = "Player" + str(playerID)
	playerIDctrl = playerID
	#item_collected = randi_range(1,10)





func on_long_press():
	if !mask_equipped:
		put_mask()
	else:
		remove_mask()
'func _process(delta: float) -> void:

		timer += delta
		if timer > 0.2:
			timer = 0
			if mask_equipped == null:
				current_HP -= 1
				$DebugLabel.text = str(current_HP)
			else:
				current_HP = clamp(current_HP + 1, 0, max_HP)
				$DebugLabel.text = str(current_HP)

			
		if current_HP <= 0 :
				Die()'

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if !isDead:
		var direction = Vector3()

			
		#CONTROLLER
		direction = Vector3(Input.get_joy_axis(playerID, JOY_AXIS_LEFT_X),0,Input.get_joy_axis(playerID, JOY_AXIS_LEFT_Y))
		if direction.x <0.6 and direction.x > -0.6:
			direction.x = 0
		if direction.z <0.6 and direction.z > -0.6:
			direction.z = 0

		if Input.is_joy_button_pressed(playerID, 0):
			DoAction()
		
		#KEYBOARD

		if Input.is_action_just_pressed("changeCtrl_L"):
			if playerIDctrl == 0:
				playerIDctrl = 3 
			elif playerIDctrl == 3:
				playerIDctrl =0
		if Input.is_action_just_pressed("changeCTRL_R"):
			if playerIDctrl == 0:
				playerIDctrl = 3 
			elif playerIDctrl == 3:
				playerIDctrl =0
		if Input.is_action_pressed("D"+str(playerIDctrl)):
			direction.z = 1
		if Input.is_action_pressed("U"+str(playerIDctrl)):
			direction.z = -1
		if Input.is_action_pressed("L"+str(playerIDctrl)):
			direction.x = -1
		if Input.is_action_pressed("R"+str(playerIDctrl)):
			direction.x = 1	
		
		if Input.is_action_just_released("A"+str(playerIDctrl)):
			holding = false
			long_pressed = false
			hold_time = 0.0
			DoAction()	
			
		if Input.is_action_pressed("A"+str(playerIDctrl)) or  Input.is_joy_button_pressed(playerID, 0):
			if  holding == false:
				holding = true
				hold_time = 0.0
				long_pressed = false

			hold_time += delta
			if hold_time >= LONG_PRESS_TIME and not long_pressed:
				on_long_press()
				long_pressed = true


			
		#if Input.is_action_just_pressed("A"+str(playerID)):
		#		DoAction()	
		'if playerID == 3: #TEMP KEYBOARD CONTROL
			#direction = Vector3()
			if Input.is_action_just_pressed("action"):
				DoAction()

			if Input.is_action_pressed("move_down"):
				direction.z = 1
			if Input.is_action_pressed("move_up"):
				direction.z = -1
			if Input.is_action_pressed("move_left"):
				direction.x = -1
			if Input.is_action_pressed("move_right"):
				direction.x = 1	
		#if input_vector.length() > 0:
			#input_vector = input_vector.normalized()'

			#var direction = Vector2(input_vector.x, input_vector.y)
		current_speed = clamp(current_speed+acceleration *delta, 0, maxspeed)
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
		
		
		if direction != Vector3(0,0,0):
				$Action_Area.look_at($Action_Area.global_position + Vector3(direction.z,0,-direction.x),Vector3.UP)
				$Area3D.look_at($Area3D.global_position + Vector3(direction.z,0,-direction.x),Vector3.UP)
		else:
			current_speed = 0	
		move_and_slide()

		if mask_equipped:
				mask_equipped.global_position = global_position + head_pos
				if direction != Vector3(0,0,0):
					mask_equipped.look_at(mask_equipped.global_position + Vector3(direction.z,0,-direction.x),Vector3.UP)
		if item_hold:
			item_hold.global_position = $Action_Area/MeshInstance3D.global_position 

func Die():
	player_has_died.emit(playerID)
	rotate_z(deg_to_rad(90))
	'if has_node("infection"):
		$DebugLabel.text = str("was INFECTED")
	else:
		$DebugLabel.text = str("NOT INFECTED")
	$DebugLabel.rotate_z(deg_to_rad(-90))
	$DebugLabel.position = Vector3(0,2.1,-3)'

	$Label3D_playername.hide()

	isDead = true

func drop_item():
	if item_hold:
		item_hold.put_back_in_world()
		item_hold = null

func collect_item(item):
	if item_hold != null:
		drop_item()
		
	item.set_as_transport()
	if item_in_proximiy.has(item):
		item_in_proximiy.erase(item)

	'if item.item_ID == "mask":
		item.rotation = Vector3(0,0,0)
		put_on_mask(item)
	else:'
	item_hold = item
	item_hold.global_position = $Action_Area/MeshInstance3D.global_position +Vector3(0,1,0)


func put_mask():
	if item_hold:
		if item_hold.item_ID == "mask":
			item_hold.rotation = Vector3(0,0,0)
			put_on_mask(item_hold)
			item_hold = null
	
func remove_mask():
	if mask_equipped:
		if !item_hold:
			item_hold = mask_equipped
			mask_equipped = null
	

	#item_collected += 1
	#$DebugLabel.text = str(item_collected)


func set_new_mask_value(value):
	mask_equipped.value =  value
	maskchanged.emit(playerID,value)


	pass

func put_on_mask(mask):
	mask_equipped = mask
	mask.global_position = global_position + head_pos
	'mask_timer_finished = false
	await get_tree().create_timer(1.0).timeout
	mask_timer_finished = true'
	maskchanged.emit(playerID,mask.value)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if !isDead:
		'if body.is_in_group("players"):
			if body.mask_equipped != null and body.mask_timer_finished:
				put_on_mask(body.mask_equipped)
				body.mask_equipped = null
				print("dddd")
				print(playerID)
				print(body.playerID)'
		if body.is_in_group("item"):
			#collect_item(body.get_parent())
			item_in_proximiy.append(body)
		if body.is_in_group("station"):
			#print("stationin")
			station_in_proximity.append(body)			

func activate_brain():
	pass

func DoAction():
	'$Action_Area.show()
	$Action_Area.monitoring = true
	await get_tree().create_timer(.2).timeout
	$Action_Area.monitoring = false
	$Action_Area.hide()'
	
	#remove_mask()
	if holding == false:
		if station_in_proximity.size() > 0:
			var station = get_closer(station_in_proximity)
			
			if item_hold:
				put_item_station(station)
			else:
				remove_item_from_station(station)
					
		
		
		
		if item_in_proximiy.size() == 0:
			if item_hold:
				drop_item()
		else:
			collect_item(get_closer(item_in_proximiy))
			
	
func put_item_station(station)	:
	print(station.name)

	if station.name =="A":
		print("transfer")
		station.get_parent().put_item_in(item_hold,"A")
		item_hold = null

	elif station.name =="B":
		print("transfer")
		station.get_parent().put_item_in(item_hold,"B")
		item_hold = null

	else:
		if station.item_in == null:
			station.put_item_in(item_hold)
			item_hold = null


func remove_item_from_station(station):
	print(station.name)
	if station.name =="A":
		print("transfer")
	elif station.name =="B":
		print("transfer")
	else:
		if station.item_in :
			item_hold = station.item_in

			station.remove_item_in()

			

func _on_action_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("players") and body != self:
		if !body.isDead:
			body.Die()


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("item"):
		if item_in_proximiy.has(body):
			item_in_proximiy.erase(body)
	if body.is_in_group("station"):
		#print("stationouta")

		if station_in_proximity.has(body):
			station_in_proximity.erase(body)		
			
func get_closer(array):
	var threshold = 10000
	var closest : Node3D
	print(array)
	for a in array:
		if global_position.distance_to(a.global_position) < threshold:
			threshold = global_position.distance_to(a.global_position)
			closest = a
	return closest
		




func _on_area_3d_area_entered(area: Area3D) -> void:
	#print(area.name)
	if area.is_in_group("station"):
		station_in_proximity.append(area)
func _on_area_3d_area_exited(area: Area3D) -> void:
	if station_in_proximity.has(area):
			station_in_proximity.erase(area)	
