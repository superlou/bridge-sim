extends Console
class_name ViewScreenConsole


@onready var PositionLabel := find_label_by_text("position")


func _ready() -> void:
	ship_net.received_message.connect(_on_ship_net_message)


func _on_ship_net_message(msg):
	if msg["source"] == "InertialComputer" and msg["label"] == "position":
		PositionLabel.text = str(msg["value"])