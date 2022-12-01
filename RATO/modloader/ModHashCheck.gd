extends "res://Network.gd"


var second_register = false
var player1_hashes
var player2_hashes

remotesync func register_player(new_player_name, id, mods):
	if not second_register:
		player1_hashes = _get_hashes(mods.active_mods)
		second_register = true
	elif second_register:
		print("This is the other player")
		player2_hashes = _get_hashes(mods.active_mods)
		
		if not _compare_checksum():
			emit_signal("game_error", "Mismatched mod versions. Verify that both players have the same version of the mod.")
			return 
	if mods.version != Global.VERSION:
		emit_signal("game_error", "Mismatched game versions. You: %s, Opponent: %s. Visit ivysly.itch.io/yomi-hustle to download the newest version." % [Global.VERSION, mods.version])
		return 
	if get_tree().get_network_unique_id() == id:
		network_id = id
	print("registering player: " + str(id))
	players[id] = new_player_name
	emit_signal("player_list_changed")
	

remote func player_connected_relay():
	rpc_("register_player", [player_name, get_tree().get_network_unique_id(), {"active_mods":ModLoader.active_mods, "version":Global.VERSION}])


	
	

func _get_hashes(active_mods):
	var hashes = []
	for item in active_mods:
		hashes.append(item[0])
	return hashes

func _compare_checksum():
	player1_hashes.sort()
	player2_hashes.sort()
	print("player1_hashes: " + str(player1_hashes))
	print("player2_hashes: " + str(player2_hashes))

	return player1_hashes == player2_hashes
