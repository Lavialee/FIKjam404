extends Node

var game_menu = preload("res://scenes/menu/menu_screen.tscn")
var game_main = preload("res://scenes/game/game_scene.tscn")
var scores_node = preload("res://scenes/menu/scores.tscn")

var savegame = File.new() #file
var save_path = "res://data" #place of the file
var save_data = {"highscore": 0} #variable to store data

var menu 
var game_scene
var scores

func _ready():
	randomize()
	start_menu()
	set_process(true)
	

func start_game():
	$menu_music.stop()
	$game_music.play()
	$church_soundscape.play()
	transition()
	yield(get_tree().create_timer(1.8), "timeout")
	game_scene = game_main.instance()
	menu.queue_free()
	game_scene.connect("timerend", self, "high_score")
	self.add_child(game_scene)

func transition():
	$CanvasLayer/fade.play("fade")
	pass

func high_score(got_score):
	scores = scores_node.instance()
	$game_music.stop()
	$church_soundscape.stop()
	self.add_child(scores)
	game_scene.queue_free()
	scores.your_score(got_score)
	yield(get_tree().create_timer(2), "timeout")
	scores.connect("back",self,"start_menu")
	pass #vyresit specificky na fikmat
#
#func create_save():
#   savegame.open(save_path, File.WRITE)
#   savegame.store_var(save_data)
#   savegame.close()
#
#func save(high_score):    
#   save_data["highscore"] = high_score #data to save
#   savegame.open(save_path, File.WRITE) #open file to write
#   savegame.store_var(save_data) #store the data
#   savegame.close() # close the file
#
#func read_savegame():
#   savegame.open(save_path, File.READ) #open the file
#   save_data = savegame.get_var() #get the value
#   savegame.close() #close the file
#   return save_data["highscore"] #return the value

func start_menu():
	$menu_music.play()
	if scores == null:
		pass
	else:
		scores.queue_free()
	menu = game_menu.instance()
	menu.connect("startgame",self,"start_game")
	self.add_child(menu)

func _process(_delta):
	if Input.is_action_pressed("key_exit"):
		get_tree().quit()
