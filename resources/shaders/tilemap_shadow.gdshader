shader_type canvas_item;

uniform vec4 corner_color : source_color = vec4(0.0, 0.0, 0.0, 1.0); // Köşeler için siyah renk
uniform float corner_size : hint_range(0.0, 24.0) = 8.0; // Köşe efektinin pixel cinsinden boyutu

void fragment() {
	vec4 base_color = texture(TEXTURE, UV);
	
	// Tile boyutu (48x48 varsayıyoruz, Godot'da TileMapLayer için varsayılan)
	float tile_size = 48.0;
	
	// Pixel koordinatlarını al (ekran koordinatları)
	vec2 pixel_pos = FRAGCOORD.xy;
	
	// Tile içindeki pozisyonu hesapla (0-tile_size arası)
	vec2 tile_local = mod(pixel_pos, tile_size);
	
	// Her köşeye olan mesafeyi hesapla
	float dist_top_left = length(tile_local - vec2(0.0, 0.0));
	float dist_top_right = length(tile_local - vec2(tile_size, 0.0));
	float dist_bottom_left = length(tile_local - vec2(0.0, tile_size));
	float dist_bottom_right = length(tile_local - vec2(tile_size, tile_size));
	
	// En yakın köşeye olan mesafeyi bul
	float min_dist = min(min(dist_top_left, dist_top_right), min(dist_bottom_left, dist_bottom_right));
	
	// Köşe efektini hesapla (corner_size içindeki alanlara siyahlık ekle)
	float corner_factor = 0.0;
	if (min_dist < corner_size) {
		// Köşeye yakınlığa göre siyahlık miktarı (daha yakın = daha koyu)
		corner_factor = 1.0 - (min_dist / corner_size);
		corner_factor = corner_factor * corner_factor; // Daha yumuşak geçiş için karesini al
	}
	
	// Base color ile corner color'ı karıştır (sadece alpha > 0 olan yerlerde)
	COLOR = mix(base_color, corner_color, corner_factor * base_color.a);
}

