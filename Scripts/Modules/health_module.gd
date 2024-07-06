extends Node3D
class_name HealthModule

signal damage_taken
signal death
@export var max_health:int
@export var health:int:
	set(value):
		health = clamp(value,0,max_health)
		if health == 0:
			death.emit()
		else:
			damage_taken.emit()
			

