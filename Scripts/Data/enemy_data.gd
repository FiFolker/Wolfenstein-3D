extends EntityData
class_name EnemyData

@export var follow_range:float
@export var attack_range:float
@export var max_view_distance:float
@export var angle_between_rays:float:
	set(value):
		angle_between_rays = deg_to_rad(value)
@export var angle_cone_vision:float:
	set(value):
		angle_cone_vision = deg_to_rad(value)
