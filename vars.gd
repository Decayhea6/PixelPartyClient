extends Node2D
var Gamemode = ""
var isRoleFinished = false
var Maxplayers = 8
var LobbyName = ""
var loaded = false
var MusicEnabled = true
var SfxEnabled = true
var Name = ""
var LeftoverRoles = []
var fallenrole = "not working"
var PlayerId = 0
var defended_player = ""
var chosenPlayer = ""
var playerInfos = {}
var winlose = ""
#I fricked up and named the port variable HostId, but i'm too lazy to go back through every menu and change it, so HostId it is.
var HostId = 0
var ServerIp = "127.0.0.1"
func connect_to_server():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ServerIp, HostId)
	get_tree().set_network_peer(peer)
	print("connected to server")
func _ready():
	get_tree().connect("server_disconnected", self, "peergobye")
	if not loaded:
		print("Loaded Settings:")
		load_settings()	
func load_settings():
	
###Change Res to user when exporting!@!@@!!@!!
		var save_game = File.new()
		if not save_game.file_exists("user://settings.json"):
			return # Error! We don't have a save to load.

		save_game.open("user://settings.json", File.READ)
		var savedata = parse_json(save_game.get_as_text())
		print(savedata)
#		MusicEnabled = savedata["music"]
#		SfxEnabled = savedata["sfx"]
		Name = savedata["username"]
		save_game.close()
remote func get_player_datas(data):
	playerInfos = data
func start_client():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ServerIp, HostId)
	get_tree().set_network_peer(peer)	
func stop_client():
	get_tree().set_network_peer(null)
remote func serversendinfo(gametype, nameoflobby):
	vars.Gamemode = gametype
	vars.LobbyName = nameoflobby
	rpc_id(1,"clientsendinfo", get_tree().get_network_unique_id(), vars.Name)
	print("data recieved")
func peergobye():
	stop_client()
	get_tree().change_scene("res://Menus/LobbyFinder.tscn")
remote func giverole(role):
	fallenrole = role
remote func startscene(scenepath):
	get_tree().change_scene(scenepath)
func sayimready():
	rpc_id(1, "playersaysready")
remote func get_protected(playerid):
	defended_player = playerid
remote func your_turn_to_go(role):
	get_tree().change_scene("res://Games/TheFallen/roles/"+str(role)+".tscn")
func display_role(therole):
	var realrole = ""
	if therole == "villager":
		realrole = "Villager"
	elif therole == "fallen":
		realrole = "Fallen"
	elif therole == "theif":
		realrole = "Thief"
	elif therole == "wizard":
		realrole = "Wizard"
	elif therole == "palladin":
		realrole = "Palladin"
	elif therole == "aethermage":
		realrole = "Aether Mage"
	elif therole == "spy":
		realrole = "Spy"
	elif therole == "guardian":
		realrole = "Guardian"
	elif therole == "restless":
		realrole = "Banshee"
	elif therole == "seer":
		realrole = "Seer"	
	elif therole == "hellspawn":
		realrole = "Hellspawn"
	elif therole == "slime":
		realrole = "Slime"	
	elif therole == "fallenseer":
		realrole = "Fallen Seer"
	elif therole == "chmo":
		realrole = "Lil Timmy"
	elif therole == "voidling":
		realrole = "Overseer"
	return(realrole)		
remote func set_leftover_roles(data):
	LeftoverRoles = data
remote func show_winscreen(game, winlose):
	pass
remote func setgamestatus(data):
	winlose = data
