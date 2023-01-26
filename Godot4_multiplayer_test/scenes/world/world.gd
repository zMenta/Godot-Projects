extends Node

@export var Player : PackedScene

@onready var menu := $CanvasLayer/Menu
@onready var map := $Map
@onready var address_entry := $CanvasLayer/Menu/MarginContainer/VBoxContainer/LineEditAddress

const PORT : int = 9999
var enet_peer := ENetMultiplayerPeer.new()


func _on_button_host_pressed() -> void:
	menu.hide()
	map.show()

	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)

	add_player(multiplayer.get_unique_id())
	# upnp_setup()


func _on_button_join_pressed() -> void:
	map.show()
	menu.hide()

	enet_peer.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = enet_peer


func remove_player(peer_id) -> void:
	var player := get_node_or_null(str(peer_id))
	if player != null:
		player.queue_free()


func add_player(peer_id) -> void:
	var player : CharacterBody2D = Player.instantiate()
	player.name = str(peer_id)
	add_child(player)


func upnp_setup() -> void:
	var upnp := UPNP.new()

	var discover_result = upnp.discover()
	assert(discover_result == UPNP.UPNP_RESULT_SUCCESS, \
		"UPNP Discover Failed! Error %s " % discover_result)

	assert(upnp.get_gateway() and upnp.get_gateway().is_valid_gateway(), \
		"UPNP Invalid Gateway!")

	var map_result = upnp.add_port_mapping(PORT)
	assert(map_result == UPNP.UPNP_RESULT_SUCCESS, \
		"UPNP Por Mapping Failed! Error %s " % map_result)

	print("Sucess! Join address: ")
	print(upnp.query_external_address())
