extends Node2D

signal timerend

onready var controls = $controls
onready var browse = $browsing_animating
onready var baby_type = $baby_type
onready var baby_animation0 = $baby_animation_node0
onready var baby_animation1 = $baby_animation_node1

var time = 90
var score = 0

var selected = 0
var hand = 0
var baby_number = 0
var yielder
var animation = 0

func _ready():
	baby_animation0.baby_type(baby_type.baby)
#	yielder = yielder_func()

func _on_controls_browseleft():
	if animation == 0 and selected != 0 and hand == 0:
		selected -= 1
		browse.browse_left_movement()

func _on_controls_browseright():
	if animation == 0 and selected != 3 and hand == 0:
		selected += 1
		browse.browse_right_movement()

func _on_controls_handconfirm():
	if hand == 0 and animation == 0:
		browse.animate_grab()
		hand = 1
		return #animate grab, change state
	elif hand == 1 and animation == 0:
		browse.animate_put_down()
		hand = 0 
		return #animate lay down, change state

func _on_controls_handuse():
	if hand == 1 and animation == 0:
		browse.animate_use()
		animation = 1
		check_correctness()
		yield(get_tree().create_timer(1), "timeout")
		browse.stop(true)
		animation = 0
		pass #animate use, stall until finished, check correctness, state stays
	else:
		pass

func _on_Timer_timeout():
	time -= 1
	if time <=0:
		$Timer.stop()
		emit_signal("timerend", score)

func check_correctness():
	if selected == baby_type.baby_heal:
		if baby_type.baby_heal == 1 and baby_number == 0:
			baby_animation0.baby_despawn()
			baby_type.baby_type_randomizer()
			baby_animation1.baby_type(baby_type.baby)
			baby_number = 1
			score += 1
			return

		if baby_type.baby_heal == 1 and baby_number == 1:
			baby_animation1.baby_despawn()
			baby_type.baby_type_randomizer()
			baby_animation0.baby_type(baby_type.baby)
			baby_number = 0
			score += 1
			return

		else:
			baby_type.baby_saved()
			baby_animation0.baby_saved()
			baby_animation1.baby_saved()
			return

	if selected != baby_type.baby_heal:
		time -= 5 
		return

func _process(_delta):
	$Text/Score.text = "Zachránils: "+str(score)
	$Text/Time.text = "Hodiny: "+str(time)

