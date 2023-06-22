extends Node

class_name playerBody

func damaged():
	Global.setPlayerHealth(Global.getPlayerHealth() - Global.getEnemyDamage())
	print(Global.getPlayerHealth())
	if Global.getPlayerHealth() <= 0:
		get_parent().queue_free()
