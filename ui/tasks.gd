extends ScrollContainer

const TASK_PATH = "res://ui/task.tscn"

@onready var box_container = $BoxContainer
@onready var timer = $Timer

var tasks = {}
var condition_id_to_remove

func add_new_task(condition_id, type, value, time):
	print("TASK: %s %s %s" % [condition_id, type, value])
	var task_scene: PackedScene = load(TASK_PATH)
	var task = task_scene.instantiate()
	task.init(type, value, time)
	box_container.add_child(task)
	tasks[condition_id] = task
	box_container.move_child(task, 0)

func task_done(condition_id):
	condition_id_to_remove = condition_id
	timer.start()

func _on_timer_timeout():
	if tasks.has(condition_id_to_remove) && tasks[condition_id_to_remove] != null:
		tasks[condition_id_to_remove].task_done()
		tasks.erase(condition_id_to_remove)

func reset():
	tasks = {}
	condition_id_to_remove = null
	for child in box_container.get_children():
		child.queue_free()
