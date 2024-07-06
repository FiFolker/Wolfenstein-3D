extends CanvasLayer

var ammo:int = 2;
var is_shooting:bool = false
var current_weapon:Weapon
@export var weapons:Array[Weapon] = [null, null, null, null]

# Called when the node enters the scene tree for the first time.
func _ready():
	$WeaponAnimation.animation_finished.connect(_on_weapon_animation_finished)
	set_weapon(0)

func _process(delta):
	$Control/HBoxContainer/Ammo/AmmoValue.text = str(ammo)
	
func _input(event):
	change_weapon(event)
	if event.is_action_pressed("attack"):
		is_shooting = true
		if current_weapon.has_ammo:
			if ammo > 0:
				ammo -= 1
				$WeaponAnimation.play("attack")
				if ammo == 0:
					set_weapon(0)
		else:
			$WeaponAnimation.play("attack")

func change_weapon(event: InputEvent) -> void:
	if event.is_action_pressed("knife"):
		set_weapon(0)
	elif event.is_action_pressed("pistol"):
		set_weapon(1)
	elif event.is_action_pressed("machine_gun"):
		set_weapon(2)
	elif event.is_action_pressed("chaingun"):
		set_weapon(3)

func set_weapon(index: int) -> void:
	if index >= 0 and index < weapons.size() and weapons[index] != null:

		current_weapon = weapons[index]
		$WeaponAnimation.sprite_frames = current_weapon
		$WeaponAnimation.play("idle")
		$Control/HBoxContainer/CenterContainer/WeaponSprite.texture = current_weapon.weapon_sprite
	else:
		print("Invalid weapon index: ", index)

func _on_weapon_animation_finished():
	is_shooting = false
	$WeaponAnimation.play("idle")

func damage(health:int):
	$Control/HBoxContainer/Health/HealthValue.text = str(health) + "%" # change ui life label
	$Control/HBoxContainer/Control/Face.play(get_good_face_animation(health))
	
func get_good_face_animation(health:int) -> String:
	var choosed_name:int
	var sprite_frames: SpriteFrames = $Control/HBoxContainer/Control/Face.sprite_frames
	var names_sorted : Array[int]
	
	for names in sprite_frames.get_animation_names(): # create Array of int to sort them and find the good anim
		names_sorted.append(int(names))
		
	names_sorted.sort()
	
	for index in range(names_sorted.size()-1): # take good animation name with the current health
		if health >= names_sorted[index] and health < names_sorted[index+1]:
			choosed_name = names_sorted[index]
	
	return str(choosed_name)
	

