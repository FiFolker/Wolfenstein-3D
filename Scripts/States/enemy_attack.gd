extends State
class_name EnemyAttack

@export var entity : Enemy

func enter():
	print("Attack State enter ...")
	entity.velocity = Vector3.ZERO

func exit():
	pass
	
func update(_delta:float):
	pass
	
func physic_update(_delta:float):
	attack()
	await entity.sprite.animation_finished
	if entity.position.distance_to(entity.player.position) > entity.enemy_data.attack_range:
		transitioned.emit(self, "EnemyFollow")

func attack():
	entity.sprite.play("attack")
	if entity.weapon.is_colliding():
		var collider = entity.weapon.get_collider()
		if collider:
			print(collider)
			var health_module = collider.find_child("HealthModule", true, false)
			if health_module:
				health_module.health -= 0
