extends Resource
class_name Weapon

@export var spriteFramesWeapon:SpriteFrames
@export var weaponName:String
@export var weaponSprite:Texture2D

func can_attack() -> bool:
	return true
	
