class_name WeaponGun
extends Weapon

var ammo = 100 # 0 de base

func attack():
	if ammo > 0:
		ammo -= 1
		self.play("attack")

func get_ammo() -> int:
	return ammo
