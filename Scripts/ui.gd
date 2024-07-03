extends CanvasLayer

@export var weapon_scene: PackedScene;
var current_weapon:Weapon
@export var weapons:Array[PackedScene]
@onready var weapon_place = $WeaponPlace

# Called when the node enters the scene tree for the first time.
func _ready():
	set_weapon(0)

func _process(delta):
	$Control/HBoxContainer/Ammo/AmmoValue.text = str(current_weapon.get_ammo())
	
func _input(event):
	change_weapon(event)

func change_weapon(event: InputEvent) -> void:
	if event.is_action_pressed("knife"):
		set_weapon(0)
	elif event.is_action_pressed("pistol"):
		set_weapon(1)
	elif event.is_action_pressed("machine_gun"):
		set_weapon(2)
	elif event.is_action_pressed("chaingun"):
		set_weapon(3)

#func change_weapon(event:InputEvent) -> void:
	#if event.is_action_pressed("knife"):
		#current_weapon = weapons[0]
		#set_weapon()
	#if event.is_action_pressed("pistol"):
		#current_weapon = weapons[1]
		#set_weapon()
	#if event.is_action_pressed("machine_gun"):
		#current_weapon = weapons[2]
		#set_weapon()
	#if event.is_action_pressed("chaingun"):
		#current_weapon = weapons[3]
		#set_weapon()
	
func set_weapon(index: int) -> void:
	if index >= 0 and index < weapons.size():
		if current_weapon:
			current_weapon.queue_free()
		var new_weapon_instance = weapons[index].instantiate()
		current_weapon = new_weapon_instance as Weapon
		weapon_place.add_child(new_weapon_instance)
		$Control/HBoxContainer/CenterContainer/WeaponSprite.texture = current_weapon.weaponSprite
	else:
		print("Invalid weapon index: ", index)
#
#func set_weapon():
	#current_weapon = weapon_scene.instantiate()
	#weapon_place.add_child(current_weapon)
	#$Control/HBoxContainer/CenterContainer/WeaponSprite.texture = current_weapon.weaponSprite
#
