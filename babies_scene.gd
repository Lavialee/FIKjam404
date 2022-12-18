extends AnimatedSprite

func _ready():
	pass # Replace with function body.

func baby_type(baby):
	self.show()
	if baby == 0:
		self.play("sul")
		baby_spawn()
	if baby == 1:
		self.play("voda")
		baby_spawn()
	if baby == 2:
		self.play("kriz")
		baby_spawn()
	if baby == 3:
		self.play("kriz2")
		baby_spawn()
	if baby == 4: 
		self.play("bible")
		baby_spawn()
	if baby == 5:
		self.play("bible2")
		baby_spawn()

func baby_spawn():
	$AnimationPlayer.play("spawn")
	
func baby_despawn():
	$AnimationPlayer.play("despawn")
	
func baby_saved():
			self.play("voda")
