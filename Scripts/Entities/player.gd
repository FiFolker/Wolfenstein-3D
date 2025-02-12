extends CharacterBody3D
class_name Player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const TURN_SPEED = 0.05
@onready var ui_script := $UI
@onready var ray_cast := $Camera3D/RayCast3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# TO DO : implement raycast with area 3D so it has a biggest shape and will be more easy to shoot enemies

func _physics_process(delta:float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("slide_left", "slide_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if Input.is_action_pressed("sprint") || Input.is_action_pressed("slide_left") || Input.is_action_pressed("slide_right"):
		velocity.x *= 2
		velocity.z *= 2
		
	if Input.is_action_pressed("ui_left") && !Input.is_action_pressed("slide_left"):
		self.rotate_y(TURN_SPEED)
	if Input.is_action_pressed("ui_right") && !Input.is_action_pressed("slide_right"):
		self.rotate_y(-TURN_SPEED)
	
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		if ui_script.is_shooting:
			shoot()
	if event.is_action_pressed("debug"):
		$HealthModule.health -= 5

func shoot() -> void:
	if ray_cast.is_colliding():
		var collider : Object = ray_cast.get_collider()
		if collider:
			var health_module : HealthModule = collider.find_child("HealthModule", true, false)
			if health_module:
				health_module.health -= 1


func _on_health_module_death() -> void:
	queue_free()
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
	

func _on_health_module_damage_taken() -> void:
	ui_script.update_health($HealthModule.health)


func _on_health_module_healed() -> void:
	ui_script.update_health($HealthModule.health)
	
func add_ammo(ammo:int) -> void:
	ui_script.update_ammo(ammo)

func add_weapon(weapon_index:int, weapon:Weapon) -> void:
	ui_script.weapons[weapon_index] = weapon


func _on_ui_on_change_weapon(range):
	#ray_cast.target_position = Vector3(0,0, -range)
	pass
