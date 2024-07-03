extends CanvasLayer

@export var current_weapon:Weapon
@export var weapons:Array[Weapon]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Weapon.animation_finished.connect(_on_weapon_animation_finished)
	set_weapon()

func _process(delta):
	var ammo = 0
	if current_weapon is GunWeapon:
		var weapon :GunWeapon = current_weapon
		current_weapon.ammo += 10
		ammo = current_weapon.ammo

	$Control/HBoxContainer/Ammo/AmmoValue.text = str(ammo)
	
func _input(event):
	change_weapon(event)
	attack(event)

func attack(event:InputEvent) -> void:
	if event.is_action_pressed("attack") && current_weapon.can_attack():
		$Weapon.play("attack")

func change_weapon(event:InputEvent) -> void:
	if event.is_action_pressed("knife"):
		current_weapon = weapons[0]
		set_weapon()
	if event.is_action_pressed("pistol"):
		current_weapon = weapons[1]
		set_weapon()
	if event.is_action_pressed("machine_gun"):
		current_weapon = weapons[2]
		set_weapon()
	if event.is_action_pressed("chaingun"):
		current_weapon = weapons[3]
		set_weapon()
	

func set_weapon():
	$Weapon.sprite_frames = current_weapon.spriteFramesWeapon
	$Weapon.play("idle")
	$Control/HBoxContainer/CenterContainer/WeaponSprite.texture = current_weapon.weaponSprite
	
	
func _on_weapon_animation_finished():
	$Weapon.play("idle")

