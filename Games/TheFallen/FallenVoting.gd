extends Node2D
var state = ""
var playerButtons = ButtonGroup.new()
const PLAYERBUTTON = preload("res://UI/PlayerButton.tscn")

func _ready():
	state = "wait"
	Input.vibrate_handheld(200)
	for player in vars.playerInfos:
		var playerbutton = PLAYERBUTTON.instance()
		$buttonContainer.add_child(playerbutton)
		playerbutton.playerid = player
		playerbutton.text = vars.playerInfos[player]["Name"].to_lower()
		playerbutton.group = playerButtons
	state = "ready"


func _on_okconfirm_pressed():
	
