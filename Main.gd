extends Node

export(PackedScene) var baby_scene
var score
var babyExists = 0
var item
var ruka = 0
func _ready():
	randomize()
	_spawnBaby()

func _spawnBaby():
	var baby = baby_scene.instance()
	babyExists =+1
	add_child(baby)

func _input(event):
	if Input.is_action_pressed("button_left"): #tlačítko K
		if ruka == 0:
			ruka += 1
			item =$Tools.get_focus_owner()
			item.release_focus()
			item.set_visible(false)
			print("hold ",item)
			return
		if ruka == 1:
			ruka -= 1
			print("lay down ",item)
			item.set_visible(true)
			item.grab_focus()
			return
			
	if Input.is_key_pressed(KEY_L):
		if ruka == 0:
			ruka += 0
			print("doing nothing")
			return
		if ruka == 1:
			ruka += 0
			print("use",item)
			#check that item is correct, then despawn, or if not correct penalize
			return
			
func _check_correctnes():
	pass
	
func _process(delta):
	if babyExists == 1:
		pass #čekni selected item, jestli 
	else:
		_spawnBaby()

