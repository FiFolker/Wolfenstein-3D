extends Node3D
class_name HealthModule

signal damage_taken
signal healed
signal death
@export var max_health:int
@export var health:int: 
	set(value):
		if value > 0:
			if value < health && value > 0:
				damage_taken.emit()
			else:
				healed.emit()
		health = clamp(value,0,max_health)
		if health == 0:
			death.emit()
		
			

func set_default_health(default_health:int) -> void:
	max_health = default_health
	self.health = default_health
