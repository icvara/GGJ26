extends Node3D


var isActive = false
var isDeactive = false
var timer = 0.2
var fog_timer = 3
var mat
var light1
var light2

var players_in_rooms = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	var mesh = $MeshInstance3D
	mat = mesh.get_active_material(0).duplicate()
	mesh.material_override = mat
	light1 = get_parent().get_node("SpotLight3D")
	light2 = get_parent().get_node("SpotLight3D2")


func dammage_players():
	for p in players_in_rooms:
		if p.mask_equipped: 
			var newvalue = clamp(p.mask_equipped.value - 0.2,0,100)
			p.set_new_mask_value(newvalue)
			if newvalue == 0:
				if !p.isDead:
					p.Die()
		else:
			if !p.isDead:
				p.Die()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isActive:
		timer -= delta
		if timer <0:
			timer = 0.1	
			var c = mat.albedo_color
			c.a = clamp(c.a + 0.2, 0, 0.9)
			mat.albedo_color = c
		if mat.albedo_color.a > 0.8:
			dammage_players()
		fog_timer -= delta
		if fog_timer <0:
			isActive =false
			isDeactive = true
			fog_timer = randi_range(3,5)
			
	if isDeactive:
		timer -= delta
		if timer <0:
			timer = 0.1	
			var c = mat.albedo_color
			c.a = clamp(c.a - 0.2, 0, 0.9)
			mat.albedo_color = c
			if c.a == 0:
				$Atmosphere.stop()

				isDeactive = false
				light1.light_color = Color(1.0, 1.0, 1.0, 1.0)
				light2.light_color = Color(1.0, 1.0, 1.0, 1.0)
	

func Activate():
	light1.light_color = Color(0.984, 0.0, 0.0, 1.0)
	light2.light_color = Color(0.984, 0.0, 0.0, 1.0)
	$Countdown1.play()
	$Atmosphere.play()

	await get_tree().create_timer(3).timeout
	isActive = true

				


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("players"):
		if players_in_rooms.has(body)==false:
			players_in_rooms.append(body)
