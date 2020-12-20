extends Node
var playerButtons = ButtonGroup.new()
var state = "start"
const PLAYERBUTTON = preload("res://UI/PlayerButton.tscn")

func _ready():
	Input.vibrate_handheld(200)
	#line below is for debugging (so you don't run the whole thing again just to test this section)
#	vars.playerInfos = {"1":{"Name":"DECAY"}, "2":{"Name":"PAUL"}, "3":{"Name":"JENNY"}}
	state = "start"
	for player in vars.playerInfos:
		if player != vars.playerId: #this stops the player from picking themselves
			var playerbutton = PLAYERBUTTON.instance()
			$buttonContainer.add_child(playerbutton)
			playerbutton.playerid = player
			playerbutton.text = vars.playerInfos[player]["Name"].to_lower()
			playerbutton.group = playerButtons
	
func _on_TouchScreenButton_pressed():#this is called when the screen is tapped
#	print(state)
	if state == "start":
		state = "chose"
		$AnimationPlayer.play("chose")
		$okconfirm.visible = true
	if state == "finished":
		vars.isRoleFinished = true
		vars.rpc_id(1, "finish_role")


func _on_okconfirm_pressed():
	if state == "chose" and playerButtons.get_pressed_button() != null:
#		print(playerButtons.get_pressed_button().playerid)
		$buttonContainer.visible = false
		$okconfirm.visible = false
		$instructions.visible = true
		$instructions.text = "- " + playerButtons.get_pressed_button().text + " -\nwas protected"
		vars.rpc_id(1, "defend_player", playerButtons.get_pressed_button().playerid)
		yield(get_tree().create_timer(0.5), "timeout")
		state = "finished"
#		print(playerButtons.get_pressed_button().text)
