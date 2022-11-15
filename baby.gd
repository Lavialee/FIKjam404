extends AnimationPlayer

var baby_name
# Called when the node enters the scene tree for the first time.
func _ready():
	spawnBaby()
	
func spawnBaby():
	self.play("BabyAnimation")
	baby_name = $Node.animation_name
	return
func despawnBaby():
	self.play("DespawnBaby")

