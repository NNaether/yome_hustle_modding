extends PlayerExtra

onready var hover_button = $"%HoverButton"

onready var fast_fall_button = $"%FastFallButton"

func _ready():
	hover_button.connect("toggled", self, "_on_hover_button_toggled")
	fast_fall_button.connect("toggled", self, "_on_fast_fall_button_toggled")


func _on_hover_button_toggled(on):
	if on:
		fast_fall_button.set_pressed_no_signal(false)
	emit_signal("data_changed")

func _on_fast_fall_button_toggled(on):
	if on:
		hover_button.set_pressed_no_signal(false)
	emit_signal("data_changed")

func show_options():
	hover_button.hide()
	fast_fall_button.hide()
	fast_fall_button.set_pressed_no_signal(fighter.fast_falling)
	hover_button.set_pressed_no_signal(fighter.hovering)
	if fast_fall_button.pressed and hover_button.pressed:
		fast_fall_button.set_pressed_no_signal(false)


	if fighter.can_hover() or fighter.hovering:
		hover_button.show()
	if not fighter.is_grounded():
		fast_fall_button.show()



func get_extra():
	var extra = {
		"hover":hover_button.pressed, 
		"fast_fall":fast_fall_button.pressed
	}
	return extra
