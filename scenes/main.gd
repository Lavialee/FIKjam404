extends Node

var game_menu = preload("res://scenes/menu/menu_screen.tscn")
var game_main = preload("res://scenes/game/game_scene.tscn")
var naming_node = preload("res://scenes/menu/scores.tscn")
var player = preload("res://scenes/Player.gd")

var savegame = File.new() #file
var save_path = "res://data" #place of the file
var save_data = {"highscore": 0} #variable to store data
var current_player = player

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
    game_scene.connect("timerend", self, "high_score") #až skončí timer, změna sceny na highscore, předává i score
    self.add_child(game_scene)

func transition():
    $CanvasLayer/fade.play("fade")
    pass

func high_score(current_score): #score je od signalu
    var naming = naming_node.instance()
    $game_music.stop()
    $church_soundscape.stop()
    self.add_child(naming)
    game_scene.queue_free()
    naming.your_score(current_score)
    yield(get_tree().create_timer(2), "timeout")
    scores.connect("back",self,"start_menu")
    pass #vyresit specificky na fikmat

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
