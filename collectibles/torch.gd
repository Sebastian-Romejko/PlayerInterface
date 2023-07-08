extends Sprite2D

signal gain_torch()

func _on_area_2d_body_entered(body):
	if body.name == "character":
		gain_torch.emit()
		queue_free()
