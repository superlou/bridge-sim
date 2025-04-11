extends Console
class_name ViewScreenConsole


@onready var PositionLabel := find_label_by_text("position")
@onready var grid_shader := $View/MoveReferenceGrid.material_override as ShaderMaterial
@onready var star_field:MultiMeshInstance3D = $View/StarField


func _ready() -> void:
	ship_net.received_message.connect(_on_ship_net_message)
	_init_star_field()


func _on_ship_net_message(msg):
	if msg["source"] == "InertialComputer" and msg["label"] == "position":
		var position:Vector3 = msg["value"]
		PositionLabel.text = str(position)

		grid_shader.set_shader_parameter("offset", position * 0.001)


func _init_star_field() -> void:
	var num_stars := 1024
	star_field.multimesh.instance_count = num_stars
	for i in range(num_stars):
		var origin := Vector3(
			randf_range(-1000, 1000),
			randf_range(-1000, 1000),
			randf_range(-1000, 1000)
		)
		var transform := Transform3D(Basis.IDENTITY, origin)
		star_field.multimesh.set_instance_transform(i, transform)
		