extends Console
class_name HelmConsole


@onready var TimeLabel := find_label_by_text("time")
@onready var VelocityLabel := find_label_by_text("velocity")


func _ready() -> void:
	ship_net.received_message.connect(_on_ship_net_message)


func _on_ship_net_message(msg):
	if msg["source"] == "TimeComputer" and msg["label"] == "run_time":
		TimeLabel.text = str(msg["value"])

	if msg["source"] == "InertialComputer" and msg["label"] == "velocity":
		VelocityLabel.text = str(msg["value"])



func _on_accelerate_button_button_pressed() -> void:
	send("accelerate")


func _on_decelerate_button_button_pressed() -> void:
	send("decelerate")
