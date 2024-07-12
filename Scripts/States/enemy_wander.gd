extends State
class_name EnemyWander

@export var entity: Enemy

var move_direction : Vector3
var wander_time : float

func randomize_wander() -> void:
	move_direction = Vector3(randf_range(-1,1), 0, randf_range(-1,1)).normalized()
	wander_time = randf_range(1,2)

func enter() -> void:
	print("Wander State enter ...")
	randomize_wander()

func exit() -> void:
	pass
	
func update(_delta:float) -> void:
	if entity.position.distance_to(entity.player.position) < entity.enemy_data.follow_range:
		transitioned.emit(self, "EnemyFollow")
	
	if wander_time > 0:
		wander_time -= _delta
	else:
		randomize_wander()
		
func physic_update(_delta:float) -> void:
	if entity:
		entity.velocity = move_direction * (entity.enemy_data.move_speed/2)
		entity.move_and_slide()
	for index in range(entity.get_slide_collision_count()):
		randomize_wander()


