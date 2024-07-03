extends CharacterBody3D

@onready var agent = $NavigationAgent3D
var speed = 1
@onready var player:CharacterBody3D = get_tree().get_first_node_in_group("Player")
var range = 5
var target:Vector3 = Vector3(5,0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	update_target_location(target)

func _process(delta):
	if player != null:
		target = player.position
		update_target_location(target)
	if velocity != Vector3.ZERO:
		$AnimatedSprite3D.play("walk")
	else:
		$AnimatedSprite3D.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	look_at(target)
	rotation.x = 0
	rotation.z = 0
	
	if position.distance_to(target) > range:
		var cur_loc = global_transform.origin
		var next_loc = agent.get_next_path_position()
		var new_vel = (next_loc - cur_loc).normalized() * speed
		velocity = new_vel
		move_and_slide()
	else:
		velocity = Vector3.ZERO

func update_target_location(target):
	agent.set_target_position(target)
