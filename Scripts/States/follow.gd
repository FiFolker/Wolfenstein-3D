extends State
class_name Follow

@export var entity:CharacterBody3D
@onready var player:CharacterBody3D = get_parent().get_parent().get_parent().get_node("Player")
@export var agent:NavigationAgent3D
@export var move_speed := 5.0
@export var activation_range:float

var target: Vector3

func enter():
	print("Follow State enter ...")

func exit():
	pass
	
func update(_delta:float):
	if player != null:
		target = player.position
		update_target_location(target)
	
func physic_update(_delta:float):

	if entity.position.distance_to(target) < activation_range:
		var cur_loc = entity.global_transform.origin
		var next_loc = agent.get_next_path_position()
		var new_vel = (next_loc - cur_loc).normalized() * move_speed
		entity.velocity = new_vel
	else:
		transitioned.emit(self, "wander")

func update_target_location(target):
	agent.set_target_position(target)
