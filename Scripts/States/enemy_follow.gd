extends State
class_name EnemyFollow

@export var entity:Enemy
@export var agent:NavigationAgent3D

var target: Vector3

func enter() -> void:
	print("Follow State enter ...")

func exit() -> void:
	pass
	
func update(_delta:float) -> void:
	if entity.player != null:
		target = entity.player.position
		update_target_location(target)
	
func physic_update(_delta:float) -> void:
	var range_to_target : float = entity.position.distance_to(target)

	if range_to_target > entity.enemy_data.attack_range:
		var cur_loc := entity.global_transform.origin
		var next_loc := agent.get_next_path_position()
		var new_vel := (next_loc - cur_loc).normalized() * entity.enemy_data. move_speed
		entity.velocity = new_vel
	else:
		transitioned.emit(self, "EnemyAttack")
		
	if range_to_target > entity.enemy_data.follow_range:
		transitioned.emit(self, "EnemyWander")

func update_target_location(target : Vector3) -> void:
	agent.set_target_position(target)
