extends AnimatedSprite

const BABYTYPES = ["sul", "voda", "kriz", "kriz2", "bible", "bible2"]
func _ready():
	pass # Replace with function body.

func baby_type(baby):
	self.play(BABYTYPES[baby])
	baby_spawn()

func baby_spawn():
	self.show()
	$AnimationPlayer.play("spawn")
	
func baby_despawn():
	$AnimationPlayer.play("despawn")
	yield(get_tree().create_timer(1.5), "timeout")
	self.hide()
	
func baby_heal():
	self.play("bile")

func baby_wrong():
	$AnimationPlayer.play("wrong")

func baby_water_shake():
	$AnimationPlayer.play("water_shake")

