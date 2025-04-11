extends Console
class_name EngineeringConsole


func _on_reactor_requested_status_change(computer_name:String,
										 status:Reactor.ReactorState
										 ) -> void:
	send("reactor_status_change", {
		"target": computer_name,
		"status": status,
	})


func _on_reactor_supply_target_changed(computer_name:String, value:float) -> void:
	send("reactor_supply_target_change", {
		"target": computer_name,
		"supply_target": value,
	})
