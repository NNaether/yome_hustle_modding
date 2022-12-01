extends CharacterState

func _frame_0():

	if host.read_advantage:
		host.start_invulnerability()


func _tick():
	host.apply_grav()
	host.apply_forces()
	if host.is_grounded() and current_tick > force_tick:
		return "UppercutLanding"

func _frame_4():
	host.end_invulnerability()
