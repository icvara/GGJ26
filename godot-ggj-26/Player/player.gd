extends CharacterBody3D

@export var gravity: float = 100.0
var playerID = 0

var mask_equipped = null
var mask_timer_finished = true

var head_pos = Vector3(0.,1.,0.)
var item_collected = 0

var isDead = false

var current_HP = 100
var max_HP = 100
var timer = 0

signal player_has_died(id)

@export var speed := 5.0
var IAcontrol = false


func _ready() -> void:
	current_HP = max_HP
	$DebugLabel.text = str(current_HP)
	$Label3D_playername.text = "Player" + str(playerID)
	#item_collected = randi_range(1,10)
	
func _process(delta: float) -> void:

		'timer += delta
		if timer > 0.2:
			timer = 0
			if mask_equipped == null:
				current_HP -= 1
				$DebugLabel.text = str(current_HP)
			else:
				current_HP = clamp(current_HP + 1, 0, max_HP)
				$DebugLabel.text = str(current_HP)'

			
		if current_HP <= 0 :
				Die()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if !isDead:
		var direction = Vector3()

		if !IAcontrol:
			direction = Vector3(Input.get_joy_axis(playerID, JOY_AXIS_LEFT_X),0,Input.get_joy_axis(playerID, JOY_AXIS_LEFT_Y))
			if direction.x <0.6 and direction.x > -0.6:
				direction.x = 0
			if direction.z <0.6 and direction.z > -0.6:
				direction.z = 0

			if Input.is_joy_button_pressed(playerID, 0):
				DoAction()
			
		
			if playerID == 3: #TEMP KEYBOARD CONTROL
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
				#input_vector = input_vector.normalized()

			#var direction = Vector2(input_vector.x, input_vector.y)
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			activate_brain()
		
		
		if direction != Vector3(0,0,0):
				$Action_Area.look_at($Action_Area.global_position + Vector3(direction.z,0,-direction.x),Vector3.UP)
		
		if mask_equipped:
				mask_equipped.global_position = global_position + head_pos
		move_and_slide()

func Die():
	player_has_died.emit(playerID)
	rotate_z(deg_to_rad(90))
	if has_node("infection"):
		$DebugLabel.text = str("was INFECTED")
	else:
		$DebugLabel.text = str("NOT INFECTED")
	$DebugLabel.rotate_z(deg_to_rad(-90))
	$DebugLabel.position = Vector3(0,2.1,-3)

	$Label3D_playername.hide()

	isDead = true

func collect_item():
	item_collected += 1
	$DebugLabel.text = str(item_collected)


func put_on_mask(mask):
	mask_equipped = mask
	mask.global_position = global_position + head_pos
	mask_timer_finished = false
	await get_tree().create_timer(1.0).timeout
	mask_timer_finished = true


func _on_area_3d_body_entered(body: Node3D) -> void:
	if !isDead:
		if body.is_in_group("players"):
			if body.mask_equipped != null and body.mask_timer_finished:
				put_on_mask(body.mask_equipped)
				body.mask_equipped = null
		if body.is_in_group("item"):
			collect_item()
			body.queue_free()		

func activate_brain():
	pass

func DoAction():
	$Action_Area.show()
	$Action_Area.monitoring = true
	await get_tree().create_timer(.2).timeout
	$Action_Area.monitoring = false
	$Action_Area.hide()

func _on_action_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("players") and body != self:
		if !body.isDead:
			body.Die()
