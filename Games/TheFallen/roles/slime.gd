
extends Node
var state = ""
var newrole = ""

func _ready():
#	next line for debugging
#	vars.LeftoverRoles = ["seer", "theif", "voidling", "wizard"]
#
	
	Input.vibrate_handheld(200)
	$FallenIcons.visible = false
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	newrole = vars.LeftoverRoles[rng.randi_range(0, vars.LeftoverRoles.size()-1)]
	state = "start"
func _on_screentapped_pressed():
	if state == "start":
		state = "wait"
		$rolename.visible = true
		$rolename.text = vars.display_role(newrole)
		$FallenIcons.play(newrole)
		$AnimationPlayer.play("transform")
		$FallenIcons.visible = true
		vars.rpc_id(1, "set_untaken_role", newrole, vars.playerInfos[vars.get_tree().get_network_unique_id()]["FallenRole"])
		vars.rpc_id(1, "set_role", vars.get_tree().get_network_unique_id(), newrole)
		state = "confirm"
func _on_readybutton_pressed():
	if state == "confirm":
		state = "finished"
		vars.isRoleFinished = true
		vars.rpc_id(1, "finish_role")
