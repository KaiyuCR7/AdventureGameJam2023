extends Node


var level = 0
var bulletHit = false
var paused = false


func setBulletHit(hit):
	bulletHit = hit

func getBulletHit():
	return bulletHit

# Each Weapon Stats - [Firerate, Speed, Damage, Projectiles, Lifetime]
var weaponData = {																		\
	0:{"Firerate":0.5,  "Speed":300,  "Damage":1, "Projectiles":1, "Lifetime":2}, 		\
	1:{"Firerate":0.2,  "Speed":300,  "Damage":1, "Projectiles":1, "Lifetime":2}, 		\
	2:{"Firerate":0.3,  "Speed":400,  "Damage":1, "Projectiles":1, "Lifetime":2}, 		\
	3:{"Firerate":0.1,  "Speed":400,  "Damage":1, "Projectiles":1, "Lifetime":2}, 		\
	4:{"Firerate":0.6,  "Speed":600,  "Damage":1, "Projectiles":5, "Lifetime":0.5}, 	\
	5:{"Firerate":0.6,  "Speed":800,  "Damage":1, "Projectiles":1, "Lifetime":0.1}, 	\
	6:{"Firerate":0.6,  "Speed":800,  "Damage":1, "Projectiles":1, "Lifetime":0.1}, 	\
	7:{"Firerate":0.6,  "Speed":1000, "Damage":1, "Projectiles":1, "Lifetime":2}, 		\
	8:{"Firerate":0.01, "Speed":1000, "Damage":1, "Projectiles":10, "Lifetime":2}}		\

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
