extends Panel
class_name SingleUIUpgrade

signal pressed()

@onready var button: Button = $Button

@export var tween_component : TweenComponent

@export var title: RichTextLabel 
@export var image: TextureRect 
@export var description: RichTextLabel 
@export var stored_upgrade : BaseStrategy :
	set(val):
		stored_upgrade = val
		
		if is_inside_tree():
			_update_ui()
		else:
			call_deferred("_update_ui")

var upgrade_text : String : 
	set(value):
		upgrade_text = value
		title.text = value
var upgrade_image : Texture2D :
	set(value):
		upgrade_image = value
		image.texture = value
var upgrade_description : String :
	set(value):
		upgrade_description = value
		description.append_text(value)

func _ready() -> void:
	call_deferred("connect_button")

func _update_ui():
	if not stored_upgrade:
		return

	if title:
		title.text = stored_upgrade.upgrade_text
	if image:
		image.texture = stored_upgrade.texture
	if description:
		description.clear()
		description.append_text(stored_upgrade.upgrade_description)
		
func _on_pressed() -> void:
	pressed.emit()
	Global.player.add_upgrade(stored_upgrade)

func connect_button():
	button.connect("pressed", _on_pressed)
	
