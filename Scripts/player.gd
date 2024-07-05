extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const TURN_SPEED = 0.05
@onready var ui_script = $UI
@onready var ray_cast = $Camera3D/RayCast3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("slide_left", "slide_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
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
	
func _input(event):
	if event.is_action_pressed("attack"):
		if ui_script.is_shooting:
			shoot()

func shoot():
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider:
			print(collider)
			var health_module = collider.find_child("HealthModule", true, false)
			if health_module:
				health_module.damage()
