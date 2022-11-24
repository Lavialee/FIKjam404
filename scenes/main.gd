extends Node

var game_menu = preload("res://scenes/menu/menu_screen.tscn")
var game_main = preload("res://scenes/game/game_scene.tscn")

var menu 
var game_scene

func _ready():
	randomize()
	start_menu()
	$menu_music.play()

func start_menu():
	menu = game_menu.instance()
	menu.connect("startgame",self,"start_game")
	self.add_child(menu)

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
	 
#func start_game_howto():
#	$menu_music.stop()
#	$game_music.play()
#	game_scene = game_main.instance()
#	game_scene.connect("timerend", self, "high_score")
#	self.add_child(game_scene)

func high_score():
	game_scene.queue_free()
	print("SEM NODE NA HIGHSCORE")
	pass #vyresit specificky na fikmat
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
