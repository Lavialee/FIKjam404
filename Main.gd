extends Node

export(PackedScene) var baby_scene
var score
var babyExists = 0
var item
var ruka = 0
var baby

func _ready():
	randomize()
	_spawnBaby()

func _spawnBaby():
	babyExists =+1
	baby = baby_scene.instance()
	baby.spawnBaby()
	return baby

func _input(event):
	var baby_name = $AnimationPlayer.baby_name
	if Input.is_action_pressed("button_left"): #tlačítko K
		if ruka == 0:
			ruka += 1
			item =$Tools.get_focus_owner()
			item.release_focus()
			item.set_visible(false)
			print("hold ",item, baby_name)
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
			_check_correctnes(item, baby_name)
			#check that item is correct, then despawn, or if not correct penalize
			return
			
func _check_correctnes(item, baby_name):
	var textItem = str(item)
	textItem.erase(textItem.length() - 13,13)
	if textItem == str(baby_name):
		print("aa")
		if textItem == "Voda":
			$AnimationPlayer.despawnBaby()
			baby.queue_free()
		return
	else:
		print("b")
		return
	pass
	
func _process(delta):
	if babyExists == 1:
		pass #čekni selected item, jestli 
	else:
		_spawnBaby()

