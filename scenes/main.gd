extends Node

var game_menu = preload("res://scenes/menu/menu_screen.tscn")
var game_main = preload("res://scenes/game/game_scene.tscn")
var naming_node = preload("res://scenes/menu/naming.tscn")
var player = preload("res://scenes/Player.gd")
var highscore_node = preload("res://scenes/menu/highscores.tscn")

var savegame = File.new() #file
var save_path = "res://data" #place of the file
var save_data = {"highscore": 0} #variable to store data
var current_player = player

var menu 
var game_scene
var naming
var scoreboard
var in_menu
func _ready():
	randomize()
	start_menu()
	set_process(true)
	
func start_game():
	in_menu = false
	$menu_music.stop()
	$game_music.play()
	$church_soundscape.play()
	transition()
	yield(get_tree().create_timer(1.8), "timeout")
	game_scene = game_main.instance()
	menu.queue_free()
	game_scene.connect("timerend", self, "name_pick") #až skončí timer, změna sceny na highscore, předává i score
	self.add_child(game_scene)

func transition():
	$CanvasLayer/fade.play("fade")
	pass

func name_pick(current_score): #score je od signalu
	$game_music.stop()
	$church_soundscape.stop()
	transition()
	yield(get_tree().create_timer(1.8), "timeout")
	naming = naming_node.instance()
	self.add_child(naming)
	game_scene.queue_free()
	naming.your_score(current_score)
	yield(get_tree().create_timer(2), "timeout")
	naming.connect("back",self,"leaderboard")
	pass #vyresit specificky na fikmat

func leaderboard():
	$highscore.play()
	scoreboard = highscore_node.instance()
	self.add_child(scoreboard)
	if in_menu == true:
		menu.queue_free()

	else:
		naming.queue_free()
	
	scoreboard.connect("back",self,"start_menu")
	pass

func start_menu():
	$menu_music.play()
	in_menu = true
	if scoreboard == null:
		pass
	else:
		scoreboard.queue_free()
	menu = game_menu.instance()
	menu.connect("startgame",self,"start_game")
	menu.connect("leaderboard",self, "leaderboard")
	self.add_child(menu)

func _process(_delta):
	if Input.is_action_pressed("key_exit"):
		get_tree().quit()
