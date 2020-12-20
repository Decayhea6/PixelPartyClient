extends Node
var state = "start"

func _ready():
	#line below is for debugging (so you don't run the whole thing again just to test this section)
#	vars.playerInfos = {"1":{"Name":"DECAY","FallenRole":"seer"}, "2":{"Name":"PAUL","FallenRole":"fallenseer"}, "3":{"Name":"JENNY","FallenRole":"fallen"}, "4":{"Name":"CARLOS","FallenRole":"guardian"}}
	Input.vibrate_handheld(200)
	state = "start"
	$dots.visible = false
	$readylabel.visible = false
	$AnimationPlayer.play("starting")
	$names.text = ""
func _on_screentapped_pressed():
	
	if state == "start":
		$AnimationPlayer.play("comrades")
		for player in vars.playerInfos:
			if vars.playerInfos[player]["FallenRole"] == "fallen" or vars.playerInfos[player]["FallenRole"] == "fallenseer":
				$names.text = $names.text + "\n" + vars.playerInfos[player]["Name"].to_lower()
		$readylabel.visible = true
		state = "viewing"


func _on_readybutton_pressed():
	$readylabel.visible = false
	if state == "viewing":
		state = "finish"
		vars.isRoleFinished = true
		$AnimationPlayer.play("vibing")
		vars.rpc_id(1, "finish_role")
