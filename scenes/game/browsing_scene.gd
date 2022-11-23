extends AnimationPlayer

var item 
var hand
var playing

signal pokus
func _ready():
	$animated_browsing.show()
	
func browse_right_movement():
	item = get_parent().selected
	$animated_0.hide()
	$animated_1.hide()
	$animated_2.hide()
	$animated_3.hide()
	$animated_browsing.show()
	var from = item - 1
	self.play("browsing_animation_" + str(from) + "_" + str(item)) 
	return

func browse_left_movement():
	item = get_parent().selected
	$animated_0.hide()
	$animated_1.hide()
	$animated_2.hide()
	$animated_3.hide()
	$animated_browsing.show()
	var from = item + 1
	self.play("browsing_animation_" + str(from) + "_" + str(item)) 
	return

func animate_grab():
	item = get_parent().selected
	var animated_item = get_node("animated_" + str(item))
	animated_item.show()
	$animated_browsing.hide()
	self.play("grab_" + str(item))
	return

func animate_use():
	item = get_parent().selected
	var animated_item = get_node("animated_" + str(item))
	animated_item.show()
	$animated_browsing.hide()
	self.play("use_" + str(item))
	return

func animate_put_down():
	item = get_parent().selected
	var animated_item = get_node("animated_" + str(item))
	animated_item.show()
	$animated_browsing.hide()
	self.play("put_down_" + str(item))
	return
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

