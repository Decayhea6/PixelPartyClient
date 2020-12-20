extends Node
var state = ""
var alibi = ""

func _ready():
	Input.vibrate_handheld(200)
	$FallenIcons.visible = false
	state = "start"
	#next line for debugging
#	vars.LeftoverRoles = ["seer", "thief", "fallen", "slime"]
func _on_screentapped_pressed():
	if state == "start":
		state = "alibi"
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		alibi = vars.LeftoverRoles[rng.randi_range(0, vars.LeftoverRoles.size()-1)]
		$rolename.text = vars.display_role(alibi)
		$FallenIcons.play(alibi)
		$AnimationPlayer.play("alibi")
		$FallenIcons.visible = true
func _on_readybutton_pressed():
	if state == "alibi":
		state = "finished"
		vars.isRoleFinished = true
		vars.rpc_id(1, "finish_role")
