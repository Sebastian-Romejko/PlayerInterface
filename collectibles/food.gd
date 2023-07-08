extends Sprite2D

signal gain_food(value)

var value = 10

func _on_area_2d_body_entered(body):
	if body.name == "character":
		gain_food.emit(10)
		queue_free()
