extends CharacterBody3D
class_name Enemy

@onready var sprite = $AnimatedSprite3D
@onready var weapon = $Weapon
@export var enemy_data : EnemyData
@onready var radar = $Radar

@onready var player: CharacterBody3D = get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	weapon.target_position = Vector3(0,0,-enemy_data.attack_range)
	$HealthModule.set_default_health(enemy_data.health)
	radar.target_position = Vector3(0,0, -enemy_data.max_view_distance)
	
func _process(delta):
	
	if velocity != Vector3.ZERO:
		sprite.play("walk")

func _physics_process(delta):
	#radar_detector()
	radar.cast_to = radar.to_local(-self.transform.basis.z * enemy_data.max_view_distance) #doesn't work idk why ...

	# Mise à jour du raycast
	radar.force_raycast_update()
	DebugDraw3D.draw_ray(self.global_transform.origin, -radar.transform.basis.z, enemy_data.max_view_distance, Color(1,1,0))
	
	if player != null:
		look_at(player.position)
		rotation.x = 0
		rotation.z = 0
	move_and_slide()

func radar_detector():
	var cast_count := int(enemy_data.angle_cone_vision / enemy_data.angle_between_rays) + 1
	
	for index in cast_count:
		var cast_vector := (
			enemy_data.max_view_distance
			* Vector3.FORWARD.rotated(Vector3.UP ,enemy_data.angle_between_rays * (index - cast_count / 2.0))
		)
		
		radar.cast_to = cast_vector
		radar.force_raycast_update()
		if radar.is_colliding() and radar.get_collider() is Player:
			print("player in vision")
			break;

func _on_health_module_damage_taken():
	sprite.play("hit")
	
func _on_health_module_death():
	sprite.play("die")
	await sprite.animation_finished
	queue_free()


func _on_animated_sprite_3d_animation_finished():
	sprite.play("idle")
