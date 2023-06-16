extends Node

class_name Damageable

func hit(damage):
	Global.setHealth(Global.getHealth() - Global.getWeaponDamage())
	print(Global.getHealth())
	if Global.getHealth() <= 0:
		print("enemy dead")
		Global.setEnemySpeed(0)
		get_parent().get_child(2).play("die")
		Global.setEnemyDead(true)
