extends CharacterBody2D

var playerID = 0

@export var speed := 50.0

func _physics_process(delta):
	var direction = null
	direction = Vector2(Input.get_joy_axis(playerID, JOY_AXIS_LEFT_X),Input.get_joy_axis(playerID, JOY_AXIS_LEFT_Y))
	if direction.x <0.6 and direction.x > -0.6:
		direction.x = 0
	if direction.y <0.6 and direction.y > -0.6:
		direction.y = 0

	#if input_vector.length() > 0:
		#input_vector = input_vector.normalized()

	#var direction = Vector2(input_vector.x, input_vector.y)
	velocity.x = direction.x * speed
	velocity.y = direction.y * speed

	move_and_slide()
