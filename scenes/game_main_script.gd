extends Node2D

signal timerend

var background = preload("res://scenes/game/background.tscn")
var control_items = preload("res://scenes/game/item_controls.tscn")
var animate_browsing = preload("res://scenes/game/browsing_scene.tscn")
var baby_type_holder = preload("res://scenes/game/enemy_type.tscn")
var animate_babies = preload("res://scenes/game/babies_scene.tscn")
var bckg = background.instance()
var controls = control_items.instance()
var browse = animate_browsing.instance()
var baby_type_node = baby_type_holder.instance()
var baby_animation = animate_babies.instance()
var baby_animation2 = animate_babies.instance()
var time = 90
var selected = 0
var babyExist = 0
var score = 0

func _ready():
	self.add_child(browse)
	self.add_child(controls)
	self.add_child(bckg)
	self.add_child(baby_type_node)
	self.add_child(baby_animation)
	self.add_child(baby_animation2)
	controls.connect("browseleft",self, "selected_left")
	controls.connect("browseright",self, "selected_right")
	controls.connect("hand", self, "check_correctness")
	controls.connect("hand", self, "hand_handle")
	baby_animation.baby_type(baby_type_node.baby)

func selected_left():
	selected -= 1
	browse.browse_left_movement()

func selected_right():
	selected += 1
	browse.browse_right_movement()
	
func _on_Timer_timeout():
	time -= 1
	if time <=0:
		$Timer.stop()
		emit_signal("timerend")

func hand_handle(state):
	if state == 0:
		pass
	if state == 1:
		browse.animate_grab()
		return

	if state == 2:
		browse.animate_use()
		return

	if state == 3:
		browse.animate_put_down()
		return
	
func check_correctness(state):
	if state == 2:
		if selected == baby_type_node.baby:
			print("correct")
			if baby_type_node.baby == 1 and babyExist == 0:
				baby_animation.baby_despawn()
				baby_type_node.baby_type_randomizer()
				baby_animation2.baby_type(baby_type_node.baby)
				babyExist = 1
				score += 1
				return
			if baby_type_node.baby == 1 and babyExist == 1:
				baby_animation2.baby_despawn()
				baby_type_node.baby_type_randomizer()
				baby_animation.baby_type(baby_type_node.baby)
				babyExist = 0
				score += 1
				return
				
			else:
				baby_type_node.baby_saved()
				baby_animation.baby_saved()
				baby_animation2.baby_saved()

				return
		if selected != baby_type_node.baby:
			print("incorrect")
			time -= 5 
			return

func _process(delta):
	$Text/Score.text = "Zachránils: "+str(score)
	$Text/Time.text = "Hodiny: "+str(time)
