extends Node
var playerButtons = ButtonGroup.new()
var state = "start"
const PLAYERBUTTON = preload("res://UI/PlayerButton.tscn")

func _ready():
	
	Input.vibrate_handheld(200)
#	print(vars.playerInfos)
#line below is for debugging (so you don't run the whole thing again just to test this section)
#	vars.playerInfos = {1:{"Name":"DECAY","FallenRole":"guardian"}, 75:{"Name":"PAUL","FallenRole":"restless"}, 3:{"Name":"JENNY","FallenRole":"thief"}, 56:{"Name":"CARLOS","FallenRole":"chmo"}}
#	vars.defended_player = 1
	$info.text ="- choose a player -\nto steal from"
	$FallenIcons.visible = false
	$info.visible = true
	$info.rect_position.y = 390.233
	$okconfirm.visible = false
	state = "start"
	$buttonContainer.visible = false

	for player in vars.playerInfos:
#		if vars.playerInfos[player]["OGFallenRole"] != "theif":
		if player != vars.get_tree().get_network_unique_id(): #this stops the player from picking themselves
			var playerbutton = PLAYERBUTTON.instance()
			$buttonContainer.add_child(playerbutton)
			playerbutton.playerid = player
			playerbutton.text = vars.playerInfos[player]["Name"].to_lower()
			playerbutton.group = playerButtons
			if int(vars.defended_player) == player:
				playerbutton.disabled = true

func _on_screenpressed_pressed():
	if state == "start":
		state = "chose"
		$info.visible = false
		$okconfirm.visible = true
		$buttonContainer.visible = true


func _on_okconfirm_pressed():
	if state == "chose" and playerButtons.get_pressed_button() != null:
		state = "wait"
		var player = playerButtons.get_pressed_button().playerid
		vars.rpc_id(1, "set_role", vars.get_tree().get_network_unique_id(), vars.playerInfos[player]["FallenRole"])
		
		$info.text = "You stole\n" + playerButtons.get_pressed_button().text + "'s role\n\nYou have\nbecome " + vars.display_role(vars.playerInfos[player]["FallenRole"])	
		$info.rect_position.y = 486.233
		$FallenIcons.play(vars.playerInfos[player]["FallenRole"])
		$FallenIcons.visible = true
		$info.visible = true
		$buttonContainer.visible = false
		vars.rpc_id(1, "set_role", player, "thief")
		yield(get_tree().create_timer(0.4), "timeout")
		state = "confirm"
	elif state == "confirm":
		state = "done"
		vars.isRoleFinished = true
		vars.rpc_id(1, "finish_role")
