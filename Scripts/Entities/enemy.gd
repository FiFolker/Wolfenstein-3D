extends CharacterBody3D

@onready var sprite = $AnimatedSprite3D
@onready var weapon = $Weapon

var range = 20
var player: CharacterBody3D
# Called when the node enters the scene tree for the first time.
func _ready():
	weapon.target_position = Vector3(0,0,-range)
	player = get_parent().get_node("Player")

func _process(delta):
	
	if velocity != Vector3.ZERO:
		sprite.play("walk")

func _physics_process(delta):
	if player != null:
		look_at(player.position)
		rotation.x = 0
		rotation.z = 0
	move_and_slide()

func attack():
	sprite.play("attack")
	if weapon.is_colliding():
		var collider = weapon.get_collider()
		if collider:
			print(collider)
			var health_module = collider.find_child("HealthModule", true, false)
			if health_module:
				health_module.health -= 1

func _on_health_module_damage_taken():
	sprite.play("hit")
	
func _on_health_module_death():
	sprite.play("die")
	await sprite.animation_finished
	queue_free()


func _on_animated_sprite_3d_animation_finished():
	sprite.play("idle")
