extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
#	$SFX.pressed = vars.SfxEnabled
	$Username.text = vars.Name
#	$Port.text = str(vars.HostId)
func _on_Apply_pressed():
#	if $SFX.pressed and not vars.SfxEnabled:
#		vars.SfxEnabled = true
#	elif not $SFX.pressed and vars.SfxEnabled:
#		vars.SfxEnabled = false
	vars.Name = $Username.text.to_upper()
	#hostid is actually the port the server will go to
#	vars.HostId = int($Port.text)
	####Save File####
	
	var save_dict = {
#		"host_id" : vars.HostId,
		"username" : vars.Name,
#		"sfx" : vars.SfxEnabled,
#		"music" : vars.MusicEnabled,
		}
	var save_game = File.new()
	save_game.open("res://settings.json", File.WRITE)
	#change res to user when exporting
#	print(to_json(save_dict))
	save_game.store_string(to_json(save_dict))
	save_game.close()
	
	#################

	get_tree().change_scene("res://MainMenu.tscn")
func _on_Go_Back_pressed():
	get_tree().change_scene("res://MainMenu.tscn")

