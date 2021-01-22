extends Node
var showing = "current"
var myid = 0
var win = false
var interactable = false
func _ready():
	showing = "current"
	interactable = false
	myid = vars.get_tree().get_network_unique_id()
	$CurrentRole.animation = vars.playerInfos[myid]["FallenRole"]
	$OgRole.animation = vars.playerInfos[myid]["OGFallenRole"]
	$AnimationPlayer.play("reset")
	yield($AnimationPlayer, "animation_finished")
	if vars.winlose == "hellspawn":
		if vars.playerInfos[myid]["FallenRole"] == "hellspawn":
			win = true
	elif vars.winlose == "fallen" and vars.playerInfos[myid]["FallenRole"] in ["fallen", "fallenseer"]:
			win = true
	elif vars.winlose == "town" and not vars.playerInfos[myid]["FallenRole"] in ["hellspawn", "fallen", "fallenseer"]:
			win = true
	else:
		win = false
	if win:
		$AnimationPlayer.play("win")
	else:
		$AnimationPlayer.play("lose")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("reveal")
	yield($AnimationPlayer, "animation_finished")
	interactable = true
func _on_screenpressed_pressed():
	if interactable:
		interactable = false
		if showing == "current":
			$AnimationPlayer.play("swap")
			showing = "og"
		else:
			$AnimationPlayer.play_backwards("swap")
			showing = "current"
		yield($AnimationPlayer, "animation_finished")
		interactable = true
