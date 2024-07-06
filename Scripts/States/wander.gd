extends State
class_name Wander

@export var entity: CharacterBody3D
@export var move_speed:=2.0
@export var activation_range:float

var move_direction : Vector3
var wander_time : float
var player:CharacterBody3D

func randomize_wander():
	move_direction = Vector3(randf_range(-1,1), 0, randf_range(-1,1)).normalized()
	wander_time = randf_range(1,2)

func enter():
	print("Wander State enter ...")
	player = get_parent().get_parent().get_parent().get_node("Player")
	randomize_wander()

func exit():
	pass
	
func update(_delta:float):
	if entity.position.distance_to(player.position) < activation_range:
		transitioned.emit(self, "follow")
	
	if wander_time > 0:
		wander_time -= _delta
	else:
		randomize_wander()
		
func physic_update(_delta:float):
	if entity:
		entity.velocity = move_direction * move_speed
		entity.move_and_slide()
	for index in range(entity.get_slide_collision_count()):
		randomize_wander()


