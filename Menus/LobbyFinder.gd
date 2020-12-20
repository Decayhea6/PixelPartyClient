extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("connected_to_server", self, "_connected_ok")


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

	
func _on_ExitButton_pressed():
	vars.stop_client()
	get_tree().change_scene("res://MainMenu.tscn")


func _on_reciever_remove_server():
	pass # Replace with function body.


func _on_reciever_new_server(serverInfo):
	vars.ServerIp = serverInfo.ip
	vars.HostId = serverInfo.port
	vars.LobbyName = serverInfo.name
	vars.connect_to_server()
	
func _connected_ok():
	$LobbyName.text = vars.LobbyName
	$Name.text = vars.Name
	$AnimationPlayer.play("server found")
	pass

func _process(delta):
	$Gamemode.text = vars.Gamemode

