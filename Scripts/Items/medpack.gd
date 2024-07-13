extends Pickable
class_name Medpack

@export var heal:int = 10

func picked(player:Player) -> void:
	var health : HealthModule = player.get_node("HealthModule")
	if health:
		print(health.health)
		print(heal)
		health.health += heal
