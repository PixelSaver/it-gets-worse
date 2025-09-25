extends Button
class_name UIUpgrade

@onready var title: Button = $VBoxContainer/Button
@onready var image: TextureRect = $VBoxContainer/CenterContainer/TextureRect
@onready var description: RichTextLabel = $VBoxContainer/UpgradeDesc

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
