extends Node

var game_menu = preload("res://scenes/menu/menu_screen.tscn")
var game_main = preload("res://scenes/game/game_scene.tscn")
var game_howto = preload("res://scenes/how_to_play/howto_screen.tscn")
var menu = game_menu.instance()
var game_scene = game_main.instance()
var howto = game_howto.instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	start_menu()
	$menu_music.play()

func start_menu():
	menu = game_menu.instance()
	menu.connect("startgame",self,"start_game")
	menu.connect("howto",self,"how_to")
	self.add_child(menu)

func start_game():
	$menu_music.stop()
	$game_music.play()
	$door.play()
	game_scene = game_main.instance()
	menu.queue_free()
	game_scene.connect("timerend", self, "high_score")
	self.add_child(game_scene)

func start_game_howto():
	$menu_music.stop()
	$game_music.play()
	game_scene = game_main.instance()
	howto.queue_free()
	game_scene.connect("timerend", self, "high_score")
	self.add_child(game_scene)


func how_to():
	$door.play()
	menu.queue_free()
	self.add_child(howto)
	howto.connect("confirm", self,"start_game_howto")

func high_score ():
	game_scene.queue_free()
	print("SEM NODE NA HIGHSCORE")
	start_menu()
	pass #vyresit specificky na fikmat
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
