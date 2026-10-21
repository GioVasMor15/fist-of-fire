extends CharacterBody2D


func _on_hurtbox_area_entered(area: Area2D) -> void:
	EventBus.attacked.emit(self, area, 10)


func _on_entity_died() -> void:
	var tween: Tween = create_tween()
	
	tween.set_parallel(true)
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	tween.tween_property(self, "scale", Vector2.ZERO, 1.0)
	
	await tween.finished
	
	queue_free()
