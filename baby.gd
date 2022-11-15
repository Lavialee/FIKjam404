extends AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnBaby()
	
func spawnBaby():
	self.play("BabyAnimation")
	return


#func _physics_process(delta):
#	velocity = (target - position).normalized() * runSpeed
#	velocity = move_and_slide(target)
#		if (target - position).length() > 5:
#		velocity = move_and_slide(velocity)
#export (int) var speed = 200
#func _input(event):
#    if event.is_action_pressed('click'):
#        target = get_global_mouse_position()
#
