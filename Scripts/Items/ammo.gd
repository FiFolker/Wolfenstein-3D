extends Pickable
class_name Ammo

@export var ammo:int = 10

func picked(player:Player) -> void:
	player.add_ammo(ammo)
