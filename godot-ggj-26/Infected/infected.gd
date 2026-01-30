extends CharacterBody3D
@export var gravity: float = 500.0

var current_wander_time = 0
var direction : Vector3
var current_speed = 30
var min_speed = 30
var max_speed = 60
var target: Node3D
var isRushing = false
var current_rushing_timer = 0

func _physics_process(delta: float) -> void:

	current_wander_time -= delta
	if target == null and !isRushing:
		if current_wander_time < 0:
			direction = Choose_New_Random_direction()
			current_wander_time = randf_range(0.2,2)
			current_speed = randf_range(min_speed,max_speed)
	elif target.isDead and !isRushing:
		if current_wander_time < 0:
			direction = Choose_New_Random_direction()
			current_wander_time = randf_range(0.2,2)
			current_speed = randf_range(min_speed,max_speed)
	else:
		

		if isRushing:
			current_rushing_timer -= delta
			if current_rushing_timer<0:
				isRushing = false
			

		else:
			
			direction = going_to(target)
			current_speed = max_speed
			
	
		
	velocity = current_speed * direction * delta
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()

func brain():
	pass
	
	
func Choose_New_Random_direction():
	return Vector3(randi_range(-1,1),0,randi_range(-1,1))
	
func going_to(t):
	return ( t.global_position -global_position).normalized()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("players"):
		if !body.isDead:
			target = body



func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("players"):
		if target == body:
			target = null


func Rushing(t):
	isRushing = true
	current_speed = max_speed *10 
	direction = going_to(target)
	current_rushing_timer = 0.3

func _on_rush_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("players"):
		if target == body and isRushing == false:
			if !body.isDead:
				Rushing(body)

				


func _on_action_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("players") and body != self:
		if !body.isDead:
			body.Die()
