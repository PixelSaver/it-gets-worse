extends Button
class_name UIUpgrade

@onready var title: Button = $VBoxContainer/Button
@onready var image: TextureRect = $VBoxContainer/CenterContainer/TextureRect
@onready var description: RichTextLabel = $VBoxContainer/UpgradeDesc
var stored_upgrade : BaseStrategy :
	set(val):
		title.text = val.upgrade_text
		image.texture = val.texture
		description.append_text(val.upgrade_description)
		stored_upgrade = val

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

func _on_pressed() -> void:
	Global.player.add_upgrade(stored_upgrade)
