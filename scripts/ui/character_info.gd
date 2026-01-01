extends HBoxContainer
class_name CharacterInfo


@export var character_name: String = ""
@onready var label: Label = $Label
@onready var texture_rect: TextureRect = $TextureRect

var empty_color: Color = Color(0.0, 0.0, 0.0, 0.0)
@export var text_color: Color = empty_color

var character_textures: Dictionary = {
	"Nehir": "res://assets/sprites/nehir.png",
	"Gökçe": "res://assets/sprites/gokce.png",
	"Yaren": "res://assets/sprites/yaren.png",
	"Buse": "res://assets/sprites/buse.png"
}

var character_scales: Dictionary = {
	"Nehir": Vector2(0.1, 0.1),
	"Gökçe": Vector2(0.12, 0.12),
	"Yaren": Vector2(0.3, 0.3),
	"Buse": Vector2(0.25, 0.25)
}


func _ready() -> void:
	assert(character_name != "")
	label.set_text(tr(self.character_name))
	
	# Karakter fotoğrafını yükle
	if character_textures.has(character_name):
		var texture_path = character_textures[character_name]
		var texture = load(texture_path)
		if texture:
			texture_rect.texture = texture
			texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
			
			# Scale için TextureRect'in boyutunu ayarla
			if character_scales.has(character_name):
				var scale_value = character_scales[character_name]
				# Texture boyutunu al ve scale uygula
				var base_size = texture.get_size()
				texture_rect.custom_minimum_size = base_size * scale_value * 1
				texture_rect.size = base_size * scale_value * 1
	
	if text_color == empty_color:
		return
	
	self.set_modulate(text_color)
