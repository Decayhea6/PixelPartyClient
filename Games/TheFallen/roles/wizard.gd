extends Node
const PLAYERBUTTON = preload("res://UI/PlayerButton.tscn")
var playerButtons = ButtonGroup.new()
var state = "start"
var player1 = 0
var player2 = 0
func _ready():
#	vars.playerInfos = {1:{"Name":"DECAY","FallenRole":"guardian"}, 75:{"Name":"PAUL","FallenRole":"wizard"}, 3:{"Name":"JENNY","FallenRole":"thief"}, 56:{"Name":"CARLOS","FallenRole":"chmo"}}
#	vars.defended_player = 75
	Input.vibrate_handheld(200)
	$info.text ="- choose two -\nplayers to swap"
	$FallenIcons.visible = false
	$info.visible = true
	$info.rect_position.y = 300
	$okconfirm.visible = false
	state = "start"
	$buttonContainer.visible = false
	for player in vars.playerInfos:
#		if vars.playerInfos[player]["FallenRole"] != "wizard":
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
		state = "chose_first"
		$info.visible = false
		$okconfirm.visible = true
		$buttonContainer.visible = true

func _on_okconfirm_pressed():
	if state == "chose_first" and playerButtons.get_pressed_button() != null:
		state = "wait"
		player1 = playerButtons.get_pressed_button().playerid
		playerButtons.get_pressed_button().queue_free()
		state = "chose_second"
	elif state == "chose_second" and playerButtons.get_pressed_button() != null:
		state = "wait"
		player2 = playerButtons.get_pressed_button().playerid
		$buttonContainer.visible = false
		$FallenIcons.play("wizard")
		$FallenIcons.visible = true
		$info.rect_position.y = 486.233
		$info.text = vars.playerInfos[player1]["Name"].to_lower() + " and " + vars.playerInfos[player2]["Name"].to_lower() + " have swapped roles"
		$info.visible = true
		var role1 = vars.playerInfos[player1]["FallenRole"]
		var role2 = vars.playerInfos[player2]["FallenRole"]
		vars.rpc_id(1, "set_role", player1, role2)
		vars.rpc_id(1, "set_role", player2, role1)
		yield(get_tree().create_timer(0.4), "timeout")
		state = "finish"
	elif state == "finish":
		state = "done"
		vars.isRoleFinished = true
		vars.rpc_id(1, "finish_role")
