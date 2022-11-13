extends Node

export(PackedScene) var mob_scene
var score
export var runSpeed = 250

func _ready():
	randomize()

func _process(delta):
	var mob = mob_scene.instance()

	var mob_spawn_location = get_node("Path2D/BabyFollow")
	mob_spawn_location.offset = $Path2D/BabyFollow._process(delta)

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


#	pass

