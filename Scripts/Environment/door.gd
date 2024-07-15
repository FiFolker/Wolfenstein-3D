extends Node3D

var can_open_door:bool = false
@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer
@onready var animated_sprite_3d = $StaticBody/AnimatedSprite3D

func _ready()->void:
	animated_sprite_3d.play("closed")
	
func _input(event) -> void:
	if event.is_action_pressed("use") && can_open_door:
		open_door()

func open_door() -> void:
	print("openning door ...")
	animated_sprite_3d.play("opened")
	animation_player.play("door_opening")
	timer.start()

func close_door() -> void:
	print("closing door ...")
	animated_sprite_3d.play("closed")
	animation_player.play_backwards("door_opening")

func _on_area_3d_body_entered(body) -> void:
	can_open_door = true


func _on_area_3d_body_exited(body) -> void:
	can_open_door = false

func _on_timer_timeout() -> void:
	close_door()
	
