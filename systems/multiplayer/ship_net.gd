extends Node
class_name ShipNet


@export var ship:Ship = null

var msgs = []

signal received_message(message)


func console_send(console:Console, label:String, value) -> void:
	send(console.ship_id, console.name, label, value)


func computer_send(computer:Computer, label:String, value) -> void:
	send(computer.ship.ship_id, computer.name, label, value)


func send(ship_id:int, source:String, label:String, value) -> void:
	var msg := {
		"ship_id": ship_id,
		"source": source,
		"label": label,
		"value": value,
	}

	if multiplayer.is_server():
		queue_for_broadcast(msg)
	else:
		queue_for_broadcast.rpc_id(0, msg)


@rpc("any_peer", "call_local", "reliable")
func queue_for_broadcast(msg:Dictionary):
	if multiplayer.is_server():
		msgs.append(msg)


@rpc("authority", "call_local", "reliable")
func broadcast(msg):
	received_message.emit(msg)


func _process(_delta: float) -> void:
	for msg in msgs:
		broadcast.rpc(msg)

	msgs = []
