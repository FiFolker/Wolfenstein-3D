extends CharacterBody3D
class_name Enemy

@onready var sprite := $AnimatedSprite3D
@onready var weapon := $Weapon
@export var enemy_data : EnemyData
@onready var radar := $Radar
@onready var weapon_cooldown = $WeaponCooldown

@onready var player: CharacterBody3D = get_tree().root.get_node("Main/Player")

var rotating_left:bool = false
var current_angle:float

var target : Object

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon.target_position = Vector3(0,0,-enemy_data.attack_range)
	$HealthModule.set_default_health(enemy_data.health)
	radar.target_position = Vector3(0,0, -enemy_data.max_view_distance)
	
func _process(delta:float) -> void:
	
	if velocity != Vector3.ZERO:
		sprite.play("walk")

func _physics_process(delta:float) -> void:
	radar_detector()
	# Mise à jour du raycast
	radar.force_raycast_update()
	
	if player != null:
		look_at(player.position)
		rotation.x = 0
		rotation.z = 0
	move_and_slide()

func _on_health_module_damage_taken() -> void:
	sprite.play("hit")
	
func _on_health_module_death() -> void:
	sprite.play("die")
	await sprite.animation_finished
	queue_free()

func _on_animated_sprite_3d_animation_finished() -> void:
	sprite.play("idle")

func radar_detector()-> void:
	# Appliquer la rotation dans la bonne direction
	if rotating_left:
		current_angle -= enemy_data.angle_between_rays
		if current_angle <= -enemy_data.angle_cone_vision / 2:
			rotating_left = false
	else:
		current_angle += enemy_data.angle_between_rays
		if current_angle >= enemy_data.angle_cone_vision / 2:
			rotating_left = true

	# Appliquer la rotation au RayCast3D
	radar.rotation_degrees.y = current_angle

	# Vérifier les collisions
	if radar.is_colliding():
		var collider: Object = radar.get_collider()
		if collider is Player:
			target = collider
		else:
			target = null
