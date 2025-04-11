extends Computer
class_name TimeComputer


@export var run_time := 0

@onready var update_timer := Timer.new()

func _ready() -> void:
	add_child(update_timer)
	update_timer.wait_time = 0.1
	update_timer.timeout.connect(_on_update_timer_timeout)
	update_timer.start()
	await get_tree().create_timer(1).timeout


func _on_update_timer_timeout():
	send("run_time", Time.get_ticks_msec() / 1000.0)
