extends Node2D
var descriptionmode = false


func _ready():
#	vars.fallenrole = "aethermage"
	vars.isRoleFinished = false
	$roleplayer.play(vars.fallenrole)


func _on_togglemode_pressed():
	if descriptionmode:
		$roleplayer.play(vars.fallenrole)
		descriptionmode = false
	else:
		$mode.play("description")
		descriptionmode = true


func _on_readybutton_pressed():
	$readybutton.visible = false
	vars.sayimready()
	$loadingdots.play("ready")
