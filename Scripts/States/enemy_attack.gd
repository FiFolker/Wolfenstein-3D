extends State
class_name EnemyAttack

@export var entity : Enemy

func enter() -> void:
	print("Attack State enter ...")
	entity.velocity = Vector3.ZERO

func exit() -> void:
	pass
	
func update(_delta:float) -> void:
	pass
	
func physic_update(_delta:float) -> void:
	attack()
	await entity.sprite.animation_finished
	if entity.position.distance_to(entity.player.position) > entity.enemy_data.attack_range:
		transitioned.emit(self, "EnemyFollow")

func attack() -> void:
	entity.sprite.play("attack")
	if entity.weapon.is_colliding():
		var collider : Object = entity.weapon.get_collider()
		if collider:
			print(collider)
			var health_module : HealthModule = collider.find_child("HealthModule", true, false)
			if health_module:
				health_module.health -= 0
