extends Control


@export var computer_name:String


signal requested_status_change(computer_name:String, status:Reactor.ReactorState)
signal supply_target_changed(computer_name:String, value:float)


var status_map := {
	Reactor.ReactorState.COLD: "Cold",
	Reactor.ReactorState.BOOTING: "Booting",
	Reactor.ReactorState.RUNNING: "Running",
	Reactor.ReactorState.STOPPING: "Stopping",
}


func _ready() -> void:
	ship_net.received_message.connect(_on_ship_net_message)
	%ComputerNameLabel.text = computer_name

	%ReactorActionMenu.get_popup().id_pressed.connect(_on_reactor_action_menu_id_pressed)


func _on_ship_net_message(msg):
	if msg.source == computer_name and msg.label == "status":
		%ReactorStatusLabel.text = str(status_map[msg.value.state])
		%ReactorSupplyLabel.text = "%.0f" % msg.value.supply
		%ReactorTemperatureLabel.text = "%4.0f°C" % msg.value.temperature
		%ReactorSupplyTargetSlider.max_value = msg.value.supply_max


func _on_reactor_action_menu_id_pressed(id:int):
	const ID_MAP := [
		Reactor.ReactorState.RUNNING,
		Reactor.ReactorState.COLD,
	]
	requested_status_change.emit(computer_name, ID_MAP[id])


func _on_reactor_supply_target_slider_value_changed(value:float) -> void:
	supply_target_changed.emit(computer_name, value)
