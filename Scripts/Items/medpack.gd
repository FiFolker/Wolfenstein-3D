extends Pickable
class_name Medpack

@export var heal:int = 10

func picked(player:Player) -> void:
	var health : HealthModule = player.get_node("HealthModule")
	print(health)
	if health:
		health.health += heal
