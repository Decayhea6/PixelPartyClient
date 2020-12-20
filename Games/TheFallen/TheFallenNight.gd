extends Node2D


func _ready():

	if vars.isRoleFinished:
		$AnimationPlayer.play("coming_back")
	else:
		$AnimationPlayer.play("start")
	print(vars.LeftoverRoles)
