extends Node
var playerButtons = ButtonGroup.new()
var state = "start"
const PLAYERBUTTON = preload("res://UI/PlayerButton.tscn")
var unusedrole = ""
func _ready():
	
	Input.vibrate_handheld(200)
#	print(vars.playerInfos)
#line below is for debugging (so you don't run the whole thing again just to test this section)
#	vars.playerInfos = {1:{"Name":"DECAY","FallenRole":"guardian"}, 75:{"Name":"PAUL","FallenRole":"restless"}, 3:{"Name":"JENNY","FallenRole":"thief"}, 56:{"Name":"CARLOS","FallenRole":"chmo"}}
#	vars.defended_player = 1
#	vars.LeftoverRoles = ["wizard", "chmo", "slime"]
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	unusedrole = vars.LeftoverRoles[rng.randi_range(0, vars.LeftoverRoles.size()-1)]
	$info.text ="- choose a player -\nto polymorph"
	$FallenIcons.visible = false
	$info.visible = true
	$info.rect_position.y = 390.233
	$okconfirm.visible = false
	state = "start"
	$buttonContainer.visible = false

	for player in vars.playerInfos:
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
		var oldrole = vars.playerInfos[player]["FallenRole"]
		vars.rpc_id(1, "set_role", player, unusedrole)
		
		$info.text = playerButtons.get_pressed_button().text + " has\npolymorphed\ninto "+vars.display_role(unusedrole)	
		$info.rect_position.y = 540
		$FallenIcons.play(unusedrole)
		$FallenIcons.visible = true
		$info.visible = true
		$buttonContainer.visible = false
		vars.rpc_id(1, "set_untaken_role", vars.LeftoverRoles.find(unusedrole), oldrole)
		yield(get_tree().create_timer(0.4), "timeout")
		state = "confirm"
	elif state == "confirm":
		state = "done"
		vars.isRoleFinished = true
		vars.rpc_id(1, "finish_role")
