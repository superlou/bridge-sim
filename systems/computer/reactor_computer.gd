extends Computer
class_name ReactorComputer


@export var reactor:Reactor


func _ready() -> void:
	ship_net.received_message.connect(_on_ship_net_message)


func _physics_process(_delta):
	send("status", {
		"state": reactor.state,
		"supply": reactor.electrical_device.supply,
		"temperature": reactor.temperature,
		"supply_max": reactor.supply_max,
		"supply_target": reactor.supply_target,
	})


func _on_ship_net_message(msg):
	if msg.source != "EngineeringConsole":
		return

	if msg.label == "reactor_status_change" and msg.value.target == name:	
		match msg.value.status:
			Reactor.ReactorState.COLD:
				reactor.stop()
			Reactor.ReactorState.IDLE:
				reactor.boot()
			Reactor.ReactorState.RUNNING:
				reactor.start()
	elif msg.label == "reactor_supply_target_change" and msg.value.target == name:
		reactor.supply_target = msg.value.supply_target
