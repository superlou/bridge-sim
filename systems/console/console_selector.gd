extends Control


signal select_helm(ship_id:int)
signal select_view_screen(ship_id:int)


func _on_select_helm_pressed() -> void:
	select_helm.emit(0)


func _on_select_view_screen_pressed() -> void:
	select_view_screen.emit(0)
