extends Weapon
class_name GunWeapon

var ammo:int:
	set(value):
		ammo = clamp(value,0,999)

func can_attack() -> bool:
	if ammo > 0:
		ammo -= 1
		return true
	return false
	
