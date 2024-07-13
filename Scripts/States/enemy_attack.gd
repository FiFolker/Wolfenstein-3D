extends State
class_name EnemyAttack

@export var entity : Enemy

var can_attack:bool = true

func enter() -> void:
	print("Attack State enter ...")
	entity.velocity = Vector3.ZERO
	if !entity.weapon_cooldown.timeout.is_connected(_can_attack):
		entity.weapon_cooldown.timeout.connect(_can_attack)

func exit() -> void:
	pass
	
func update(_delta:float) -> void:
	pass
	
func physic_update(_delta:float) -> void:
	if can_attack:
		attack()
	#await entity.sprite.animation_finished
	if entity.target == null:
		transitioned.emit(self, "EnemyWander")
	
	if entity.position.distance_to(entity.player.position) > entity.enemy_data.attack_range:
		transitioned.emit(self, "EnemyFollow")

func attack() -> void:
	entity.sprite.play("attack")
	if entity.weapon.is_colliding():
		var collider : Object = entity.weapon.get_collider()
		if collider:
			var health_module : HealthModule = collider.find_child("HealthModule", true, false)
			if health_module:
				var rng = randf()
				if rng > 0.4:
					health_module.health -= 5
				entity.weapon_cooldown.start()
				can_attack = false

func _can_attack() -> void:
	can_attack = true
