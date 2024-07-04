extends AnimatedSprite2D
class_name Weapon

@export var weaponSprite:Texture2D
@export var range:int

func attack():
	self.play("attack")

func get_ammo() -> int:
	return 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.play("idle")
	self.animation_finished.connect(_on_weapon_animation_finished)

func _input(event):
	if event.is_action_pressed("attack"):
		attack()
	
func _on_weapon_animation_finished():
	self.play("idle")
