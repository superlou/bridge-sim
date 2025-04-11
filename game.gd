extends Node

var ShipMk1Scene := preload("res://ships/ship_mk_1/ship_mk_1.tscn")
var HelmScene := preload("res://consoles/helm/helm_console.tscn")
var ViewScreenScene := preload("res://consoles/view_screen/view_screen_console.tscn")
var EngineeringConsoleScene := preload("res://consoles/engineering/engineering_console.tscn")


func _ready() -> void:
	# Preconfigure game
	Lobby.player_loaded.rpc_id(1)

	if "helm" in OS.get_cmdline_args():
		add_helm_console(0)
	elif "view-screen" in OS.get_cmdline_args():
		add_view_screen_console(0)
	elif "engineering" in OS.get_cmdline_args():
		add_engineering_console(0)


func start_game():
	# All peers are ready to receive RPCs in this scene.
	print("Starting game on server.")
	if multiplayer.is_server():
		init_scenario()


func init_scenario():
	var ship := ShipMk1Scene.instantiate()
	ship.name = "CrewShip"
	$Scenario.add_child(ship)
	print("added ship")


func add_helm_console(ship_id:int) -> void:
	var console = HelmScene.instantiate()
	console.name = "HelmConsole"
	console.ship_id = 0
	add_child(console)
	$ConsoleSelector.hide()


func add_view_screen_console(ship_id:int) -> void:
	var console = ViewScreenScene.instantiate()
	console.name = "ViewScreenConsole"
	console.ship_id = 0
	add_child(console)
	$ConsoleSelector.hide()


func add_engineering_console(ship_id:int) -> void:
	var console = EngineeringConsoleScene.instantiate()
	console.name = "EngineeringConsole"
	console.ship_id = 0
	add_child(console)
	$ConsoleSelector.hide()
