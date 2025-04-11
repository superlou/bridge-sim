extends Computer
class_name ThrustComputer


func _ready() -> void:
	ship_net.received_message.connect(_on_ship_net_message)


func _on_ship_net_message(msg):
	if msg["source"] == "HelmConsole" and msg["label"] == "accelerate":
		ship.velocity.z -= 1
	
	if msg["source"] == "HelmConsole" and msg["label"] == "decelerate":
		ship.velocity.z += 1