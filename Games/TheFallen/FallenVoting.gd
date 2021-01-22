extends Node2D
var state = ""
var playerButtons = ButtonGroup.new()
const PLAYERBUTTON = preload("res://UI/PlayerButton.tscn")

func _ready():
	state = "wait"
	Input.vibrate_handheld(500)
	for player in vars.playerInfos:
		var playerbutton = PLAYERBUTTON.instance()
		$buttonContainer.add_child(playerbutton)
		playerbutton.playerid = player
		playerbutton.text = vars.playerInfos[player]["Name"].to_lower()
		playerbutton.group = playerButtons
	state = "ready"


func _on_okconfirm_pressed():
	
	if state == "ready":
		var chosenplayer = playerButtons.get_pressed_button().playerid
		state = "waiting"
		$youvotedfor.text = "You voted for:\n" + vars.playerInfos[chosenplayer]["Name"].to_lower()
		vars.rpc_id(1, "vote_for", chosenplayer, vars.get_tree().get_network_unique_id())
		$AnimationPlayer.play("waiting")
		
