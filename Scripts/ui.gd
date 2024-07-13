extends CanvasLayer

var ammo:int = 2;
var is_shooting:bool = false
var current_weapon:Weapon
@export var weapons:Array[Weapon] = [null, null, null, null]

@onready var floor_value := $Control/HBoxContainer/Floor/FloorValue
@onready var score_value := $Control/HBoxContainer/Score/ScoreValue
@onready var lives_value := $Control/HBoxContainer/Lives/LivesValue
@onready var face := $Control/HBoxContainer/Control/Face
@onready var health_value := $Control/HBoxContainer/Health/HealthValue
@onready var ammo_value := $Control/HBoxContainer/Ammo/AmmoValue
@onready var weapon_sprite := $Control/HBoxContainer/CenterContainer/WeaponSprite


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$WeaponAnimation.animation_finished.connect(_on_weapon_animation_finished)
	set_weapon(0)

func _process(delta:float) -> void:
	ammo_value.text = str(ammo)
	
func _input(event:InputEvent) -> void:
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
		weapon_sprite.texture = current_weapon.weapon_sprite
	else:
		print("Invalid weapon index: ", index)

func _on_weapon_animation_finished() -> void:
	is_shooting = false
	$WeaponAnimation.play("idle")

func update_health(health:int) -> void:
	health_value.text = str(health) + "%" # change ui life label
	face.play(get_good_face_animation(health))
	
func get_good_face_animation(health:int) -> String:
	var choosed_name:int
	var sprite_frames: SpriteFrames = face.sprite_frames
	var names_sorted : Array[int]
	
	for names in sprite_frames.get_animation_names(): # create Array of int to sort them and find the good anim
		names_sorted.append(int(names))
		
	names_sorted.sort()
	
	for index in range(names_sorted.size()-1): # take good animation name with the current health
		if health >= names_sorted[index] and health <= names_sorted[index+1]:
			choosed_name = names_sorted[index]
	
	return str(choosed_name)
	
func update_ammo(new_ammo:int) -> void:
	self.ammo += new_ammo
	ammo_value.text = str(self.ammo)
