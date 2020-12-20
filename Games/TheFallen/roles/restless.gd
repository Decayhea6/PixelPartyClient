extends Node
var state = ""
var myrole = ""
func _ready():
#	vars.playerInfos = {0:{"Name":"DECAY","FallenRole":"theif"}, 75:{"Name":"PAUL","FallenRole":"restless"}, 3:{"Name":"JENNY","FallenRole":"wizard"}, 56:{"Name":"CARLOS","FallenRole":"chmo"}}
	state = "start"
	Input.vibrate_handheld(200)
	$FallenIcons.visible = false
	myrole = vars.playerInfos[vars.get_tree().get_network_unique_id()]["FallenRole"]
	$rolename.text = vars.display_role(myrole)
	$FallenIcons.play(myrole)


func _on_readybutton_pressed():
	if state == "finish":
		state = "wait"
		vars.isRoleFinished = true
		vars.rpc_id(1, "finish_role")


func _on_screentapped_pressed():
	if state == "start":
		state = "wait"
		$AnimationPlayer.play("reveal")
		$FallenIcons.visible = true
		state = "finish"
