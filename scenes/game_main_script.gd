extends Node2D

signal timerend

onready var browse = $browsing_animating
onready var baby_animation0 = $baby_animation_node0
onready var baby_animation1 = $baby_animation_node1

var time = 100
var score = 0

var stun = false
var selected = 0
var hand_full = false
var baby_number = 0
var busy = false
var baby_busy = false
var baby_type
var baby_heal

func _ready():
	randomize()
	baby_type_randomizer()
	baby_animation0.baby_type(baby_type)
	
func baby_type_randomizer():
	baby_type = (randi() % 5)
	if baby_type == 0:
		baby_heal = 0
	elif baby_type == 1:
		baby_heal = 1
	elif baby_type == 2 or baby_type == 3:
		baby_heal = 2
	elif baby_type == 4 or baby_type == 5:
		baby_heal = 3


func _input(event):
	if time != 0:
		if event.is_action_pressed("ui_left"):
			if busy == false and hand_full == false and selected != 0:
				selected -= 1
				browse.browse_left_movement()

		if event.is_action_pressed("ui_right"):
			if busy == false and hand_full == false and selected != 3:
				selected += 1
				browse.browse_right_movement()

		if event.is_action_pressed("confirm"):
			if busy == false and hand_full == false:
				browse.animate_grab()
				hand_full = true
				yield(get_tree().create_timer(3), "timeout")
				return #animate grab, change state

			elif busy == false and hand_full == true:
				browse.animate_put_down()
				hand_full = false
				return #animate lay down, change state

		if event.is_action_pressed("use"):
			if busy == false and hand_full == true and baby_busy == false:
				browse.animate_use()
				check_correctness()
	#			browse.stop(true)
	#			busy = false
				return #animate use, stall until finished, check correctness, state 

func _on_Timer_timeout():
	time -= 1
	$TimeLine.points[1].x -= 10
	if time <=0:
		$Timer.stop()
		$bell.play()
		emit_signal("timerend", score)

func check_correctness():
	if time != 0:
		if selected == 0:
			$salt_shake.play()
		if selected == 1:
			$water_splash.play()
		if selected == 2:
			$incantation.play()
		if selected == 3: #uses bible
			$page_turn.play()

		if selected == baby_heal: #was correct
			if baby_heal == 1: #healed by water, despawns
				baby_type_randomizer()
				score +=1
				var sound = (randi() % 2)
				print(sound)
				if sound == 1:
					$baby_sound.play_random()
					pass
				if baby_number == 0: 
					baby_animation0.baby_despawn()
					baby_animation1.baby_type(baby_type)
					baby_number = 1
					busy = true #waits for the usage animation to end
					baby_busy = true
					yield(get_tree().create_timer(1), "timeout") 
					busy = false
					yield(get_tree().create_timer(0.5), "timeout")
					baby_busy = false
					return
				if baby_number == 1:
					baby_animation1.baby_despawn()
					baby_animation0.baby_type(baby_type)
					baby_number = 0
					busy = true #waits for the usage animation to end
					baby_busy = true
					yield(get_tree().create_timer(1), "timeout") 
					busy = false
					yield(get_tree().create_timer(0.5), "timeout")
					baby_busy = false
					return
			else: #healed to normal baby (water)
				baby_animation0.baby_heal()
				baby_animation1.baby_heal()
				baby_heal = 1
				busy = true
				yield(get_tree().create_timer(0.9), "timeout") 
				busy = false
				return

		if selected != baby_heal: #wrong healing item
			if baby_heal == 1: #baby not satanic, just shakes, no stun
				baby_animation0.baby_water_shake()
				baby_animation1.baby_water_shake()
			else: #baby still cursed, player gets stunned
				var sound = (randi() % 3)
				if sound == 1:
					$demon_sound.play_random()
					pass
				busy = true
				baby_animation0.baby_wrong()
				baby_animation1.baby_wrong()
				yield(get_tree().create_timer(3), "timeout")
				busy = false
		return
func _process(_delta):
	$Text/Score.text = "Zachránils: "+str(score)
