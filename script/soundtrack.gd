extends AudioStreamPlayer

enum Mood {BASS, DRUMS, MELODY, FULL, SILENCE}

@export var bass_index: int
@export var drums_index: int
@export var melody_index: int


func change_config(cfg: SoundtrackConfig, duration: float = 5.0) -> void:
	var tween: Tween = create_tween()
	tween.set_parallel(true)
	tween.tween_method(fade_stream_volume.bind(bass_index), stream.get_sync_stream_volume(bass_index), cfg.bass_volume, duration)
	tween.tween_method(fade_stream_volume.bind(drums_index), stream.get_sync_stream_volume(drums_index), cfg.drums_volume, duration)
	tween.tween_method(fade_stream_volume.bind(melody_index), stream.get_sync_stream_volume(melody_index), cfg.melody_volume, duration)

func change_mood(mood: Mood, duration: float = 5.0) -> void:
	match mood:
		Mood.BASS:
			var tween: Tween = create_tween()
			tween.set_parallel(true)
			tween.tween_method(fade_stream_volume.bind(bass_index), stream.get_sync_stream_volume(0), 0, duration)
			tween.tween_method(fade_stream_volume.bind(drums_index), stream.get_sync_stream_volume(1), -60, duration)
			tween.tween_method(fade_stream_volume.bind(melody_index), stream.get_sync_stream_volume(2), -60, duration)
		Mood.DRUMS:
			var tween: Tween = create_tween()
			tween.set_parallel(true)
			tween.tween_method(fade_stream_volume.bind(bass_index), stream.get_sync_stream_volume(0), -60, duration)
			tween.tween_method(fade_stream_volume.bind(drums_index), stream.get_sync_stream_volume(1), 0, duration)
			tween.tween_method(fade_stream_volume.bind(melody_index), stream.get_sync_stream_volume(2), -60, duration)
		Mood.MELODY:
			var tween: Tween = create_tween()
			tween.set_parallel(true)
			tween.tween_method(fade_stream_volume.bind(bass_index), stream.get_sync_stream_volume(0), -60, duration)
			tween.tween_method(fade_stream_volume.bind(drums_index), stream.get_sync_stream_volume(1), -60, duration)
			tween.tween_method(fade_stream_volume.bind(melody_index), stream.get_sync_stream_volume(2), 0, duration)
		Mood.FULL:
			var tween: Tween = create_tween()
			tween.set_parallel(true)
			tween.tween_method(fade_stream_volume.bind(bass_index), stream.get_sync_stream_volume(0), 0, duration)
			tween.tween_method(fade_stream_volume.bind(drums_index), stream.get_sync_stream_volume(1), 0, duration)
			tween.tween_method(fade_stream_volume.bind(melody_index), stream.get_sync_stream_volume(2), 0, duration)
		Mood.SILENCE:
			var tween: Tween = create_tween()
			tween.set_parallel(true)
			tween.tween_method(fade_stream_volume.bind(bass_index), stream.get_sync_stream_volume(0), -60, duration)
			tween.tween_method(fade_stream_volume.bind(drums_index), stream.get_sync_stream_volume(1), -60, duration)
			tween.tween_method(fade_stream_volume.bind(melody_index), stream.get_sync_stream_volume(2), -60, duration)


func fade_stream_volume(volume_db: float, stream_index: int) -> void:
	var sync_stream := stream as AudioStreamSynchronized
	sync_stream.set_sync_stream_volume(stream_index, volume_db)
