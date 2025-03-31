extends Node
class_name ThrustComputer


@export var ship:Ship = null


func _ready() -> void:
	ship_net.received_message.connect(_on_ship_net_message)


func _on_ship_net_message(msg):
	if msg["source"] == "HelmConsole" and msg["label"] == "accelerate":
		ship.velocity.x += 1