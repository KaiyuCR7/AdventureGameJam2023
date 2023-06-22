extends Node

var level = 0

var enemyHealth = 3
var weaponDamage = 1
var enemyDamage = 1
var enemyHit = false
var enemyDead = false
var playerPos = Vector2(0,0)
var playerHealth = 3
var enemySpeed = 80


var paused = false
var bulletHit = false


#For Bullet Bounce
var canBounce = false
var bounceAmount = 1

func setBulletHit(hit):
	bulletHit = hit

func getBulletHit():
	return bulletHit
	
func getEnemySpeed():
	return enemySpeed

func setEnemySpeed(speed):
	enemySpeed = speed

func getPlayerHealth():
	return playerHealth

func setPlayerHealth(health):
	playerHealth = health

func getPlayerPositionX():
	return playerPos.x

func setPlayerPositionX(position):
	playerPos.x = position

func getPlayerPositionY():
	return playerPos.y

func setPlayerPositionY(position):
	playerPos.y = position

func getHealth():
	return enemyHealth

func setHealth(health):
	enemyHealth = health

func getWeaponDamage():
	return weaponDamage

func setWeaponDamage(damage):
	weaponDamage = damage

func getEnemyDamage():
	return enemyDamage

func setEnemyDamage(damage):
	enemyDamage = damage

func getEnemyHit():
	return enemyHit

func setEnemyHit(hit):
	enemyHit = hit

func getEnemyDead():
	return enemyDead

func setEnemyDead(dead):
	enemyDead = dead

# Each Weapon Stats - [Firerate, Speed, Damage, Projectiles, Lifetime]
var weaponData = {																		\
	0:{"Firerate":0.5,  "Speed":4,  "Damage":1, "Projectiles":1, "Lifetime":2}, 		\
	1:{"Firerate":0.2,  "Speed":3,  "Damage":1, "Projectiles":1, "Lifetime":2}, 		\
	2:{"Firerate":0.3,  "Speed":4,  "Damage":1, "Projectiles":1, "Lifetime":2}, 		\
	3:{"Firerate":0.1,  "Speed":4,  "Damage":1, "Projectiles":1, "Lifetime":2}, 		\
	4:{"Firerate":0.6,  "Speed":6,  "Damage":1, "Projectiles":5, "Lifetime":0.5}, 	\
	5:{"Firerate":0.6,  "Speed":8,  "Damage":1, "Projectiles":1, "Lifetime":0.1}, 	\
	6:{"Firerate":0.6,  "Speed":8,  "Damage":1, "Projectiles":1, "Lifetime":0.1}, 	\
	7:{"Firerate":0.6,  "Speed":10, "Damage":1, "Projectiles":1, "Lifetime":2}, 		\
	8:{"Firerate":0.01, "Speed":10, "Damage":1, "Projectiles":10, "Lifetime":2}}		\

# Current Weapon List - Subject to Change
# 0 - Pistol
# 1 - SMG
# 2 - AR
# 3 - MiniGun
# 4 - Shotty
# 5 - Red Saber
# 6 - Blue Saber
# 7 - Sniper
# 8 - Banana
