extends Node
class_name State

signal transitioned(current_state: State, new_state:String)

func enter() -> void:
	pass

func exit() -> void:
	pass
	
func update(_delta:float) -> void:
	pass
	
func physic_update(_delta:float) -> void:
	pass
