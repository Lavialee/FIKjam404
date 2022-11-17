extends AnimatedSprite

func _ready():
	pass # Replace with function body.

func baby_type(baby):
	self.show()
	if baby == 0:
		self.play("sul")
		print("sullll")
		baby_spawn()
	if baby == 1:
		self.play("voda")
		print("vodaaa")
		baby_spawn()
	if baby == 2:
		var random = randi()%1
		if random == 0: 
			self.play("kriz")
			print("krizzz")
			baby_spawn()
		else:
			self.play("kriz2")
			print("krizzz")
			baby_spawn()
	if baby == 3:
		var random = randi()%1
		if random == 0: 
			self.play("bible")
			print("bibleee")
			baby_spawn()
		else:
			self.play("bible2")
			print("bibleeee")
			baby_spawn()

func baby_spawn():
	$AnimationPlayer.play("spawn")
	
func baby_despawn():
	$AnimationPlayer.play("despawn")
	
func baby_saved():
			self.play("voda")
