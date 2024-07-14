extends Sprite3D
class_name Pickable

@export var pickable_data:PickableData
@onready var player: CharacterBody3D = get_tree().root.get_node("Main/Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.texture = pickable_data.sprite


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if player != null:
		self.look_at(player.position)

func picked(player : Player) -> void:
	pass

func _on_area_3d_body_entered(body:Node3D):
	if body is Player:
		picked(body as Player) 
		queue_free()
