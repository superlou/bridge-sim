extends Console
class_name ViewScreenConsole


@onready var PositionLabel := find_label_by_text("position")
@onready var grid_shader := $View/MoveReferenceGrid.material_override as ShaderMaterial


func _ready() -> void:
	ship_net.received_message.connect(_on_ship_net_message)


func _on_ship_net_message(msg):
	if msg["source"] == "InertialComputer" and msg["label"] == "position":
		var position:Vector3 = msg["value"]
		PositionLabel.text = str(position)

		grid_shader.set_shader_parameter("offset", position * 0.001)
