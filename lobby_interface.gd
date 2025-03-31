extends VBoxContainer


func _ready() -> void:
	Lobby.player_connected.connect(_on_player_connected)
	Lobby.player_disconnected.connect(_on_player_disconnected)

	if "host" in OS.get_cmdline_args():
		_host_game()
	elif "join" in OS.get_cmdline_args():
		await get_tree().create_timer(0.2).timeout
		_join_game()


func _host_game() -> void:
	var error = Lobby.create_game()

	if error:
		_add_info("Error hosting (%s)" % error)
		return

	get_tree().change_scene_to_file("res://game.tscn")


func _join_game() -> void:
	var error = Lobby.join_game(%JoinIP.text)

	if error:
		_add_info("Error joining (%s)" % error)
		return

	get_tree().change_scene_to_file("res://game.tscn")


func _add_info(text:String):
	$NetworkInfo.text += text + "\n"


func _on_player_connected(peer_id, player_info):
	_add_info("Player connected (peer id = %s, player info = %s)" % [peer_id, player_info])


func _on_player_disconnected(peer_id):
	_add_info("Player disconnected (peer id = %s)" % peer_id)


func _on_host_button_pressed() -> void:
	_host_game()


func _on_join_button_pressed() -> void:
	_join_game()
