extends Node
const PLAYERBUTTON = preload("res://UI/PlayerButton.tscn")
var state = "start"
var playerButtons = ButtonGroup.new()

func _ready():

#	vars.playerInfos = {1:{"Name":"DECAY","FallenRole":"guardian"}, 75:{"Name":"PAUL","FallenRole":"restless"}, 3:{"Name":"JENNY","FallenRole":"thief"}, 56:{"Name":"CARLOS","FallenRole":"chmo"}}
#	vars.defended_player = 3

	Input.vibrate_handheld(200)
	$title.text = ""
	$info.text ="- choose a player -\nto investigate"
	$FallenIcons.visible = false
	$info.rect_position.y = 375.366
	$okconfirm.visible = false
	state = "start"
	$buttonContainer.visible = false
	
	for player in vars.playerInfos:
#		if vars.playerInfos[player]["OGFallenRole"] != "spy":
		if player != vars.get_tree().get_network_unique_id(): #this stops the player from picking themselves
			var playerbutton = PLAYERBUTTON.instance()
			$buttonContainer.add_child(playerbutton)
			playerbutton.playerid = player
			playerbutton.text = vars.playerInfos[player]["Name"].to_lower()
			playerbutton.group = playerButtons
			if int(vars.defended_player) == player:
				playerbutton.disabled = true	
	
func _on_okconfirm_pressed():
	if state == "chose" and playerButtons.get_pressed_button() != null:
		state = "wait"
		var chosenplayer = playerButtons.get_pressed_button().playerid
		$buttonContainer.visible = false
		$FallenIcons.play(vars.playerInfos[chosenplayer]["FallenRole"])
		$FallenIcons.visible = true
		$title.text = vars.display_role(vars.playerInfos[chosenplayer]["FallenRole"])
		$info.text = "you discover\nthat this is\n" + vars.playerInfos[chosenplayer]["Name"].to_lower() + "'s role"
		yield(get_tree().create_timer(0.4), "timeout")
		state = "results"
	elif state == "results":
		state = "done"
		vars.isRoleFinished = true
		vars.rpc_id(1, "finish_role")
func _on_screenpressed_pressed():
	if state == "start":
		state = "chose"
		$info.rect_position.y = 615.366
		$info.text = ""
		$buttonContainer.visible = true
		$okconfirm.visible = true
