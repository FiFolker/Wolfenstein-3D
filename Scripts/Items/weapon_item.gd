extends Pickable

@export var weapon_index:int
@export var weapon:Weapon

func picked(player:Player)->void:
	player.add_weapon(weapon_index, weapon)
