extends BoxContainer

const PATH = "res://art/ui/tasks/%s.png"

@onready var label = $Control/Label
@onready var texture = $TextureRect
@onready var timer_bar = $Control2/TextureProgressBar 

var text_value
var texture_path
var timeout_value

var timeout

func init(type, value, time):
	if type == "mistake":
		text_value = "mistake"
	else:
		text_value = "+%d %s" % [value, type] if value > 0 else "%d %s" % [value, type]
	texture_path = load(PATH % type)
	timeout_value = time

func _ready():
	label.text = text_value
	texture.texture = texture_path
	timeout = timeout_value
	timer_bar.max_value = timeout

func _process(delta):
	if timeout != null:
		timeout -= delta
		timer_bar.value = timeout
		if timeout <= 0:
			queue_free()

func task_done():
	queue_free()
