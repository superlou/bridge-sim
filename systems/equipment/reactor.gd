extends Node3D
class_name Reactor


@onready var electrical_device:ElectricalDevice = $ElectricalDevice
@export var state := ReactorState.COLD
@export var temperature := 23.0
@export var supply_max := 1000.0
@export var supply_target := 0.0
var target_state := state

enum ReactorState {
	COLD,
	BOOTING,
	IDLE,
	STARTING,
	RUNNING,
	STOPPING,
}


func _physics_process(delta):
	var enter := false

	# Update state
	match state:
		ReactorState.COLD:
			if target_state == ReactorState.RUNNING:
				state = ReactorState.BOOTING
				enter = true
		ReactorState.BOOTING:
			if temperature >= 300.0:
				state = ReactorState.RUNNING
				enter = true

	# Run state
	match state:
		ReactorState.COLD:
			process_state_cold(delta, enter)
		ReactorState.BOOTING:
			process_state_booting(delta, enter)
		ReactorState.RUNNING:
			process_state_running(delta, enter)


func process_state_cold(_delta:float, _enter:bool):
	temperature = 28
	electrical_device.supply = 0.0


func process_state_booting(_delta:float, enter:bool):
	if enter:
		get_tree().create_tween().tween_property(self, "temperature", 300.0, 3).set_trans(Tween.TRANS_SINE)
	
	electrical_device.supply = 0.0


func process_state_running(delta:float, _enter:bool):
	electrical_device.supply = lerp(electrical_device.supply, supply_target, 1.0 * delta)

	temperature = 300 + electrical_device.supply / 2.8

	if electrical_device.supply > 0.8 * supply_max:
		var excess := electrical_device.supply - 0.8 * supply_max
		temperature += excess


func start():
	target_state = ReactorState.RUNNING


func stop():
	target_state = ReactorState.COLD
