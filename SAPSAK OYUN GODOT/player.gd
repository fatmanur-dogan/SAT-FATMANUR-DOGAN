extends KinematicBody2D

# Hızımızı piksel/saniye cinsinden ayarlayalım.
var hiz = 200

# _ready fonksiyonu sahne başladığında bir kez çalışır.
# Şimdilik buna ihtiyacımız yok, o yüzden 'pass' yazıp geçiyoruz.
func _ready():
	pass

# _physics_process fonksiyonu her fizik karesinde (genellikle saniyede 60 kez) çalışır.
# Hareket kodları buraya yazılır.
func _physics_process(delta):
	
	# 1. Hangi tuşa basıldığını kontrol etmek için boş bir yön değişkeni oluştur
	var yon = Vector2() # Başlangıçta (0,0) yani hareketsiz
	
	# "Proje Ayarları"nda tanımladığımız eylemleri kontrol et
	if Input.is_action_pressed("saga_git"):
		yon.x += 1 # Sağa git (X ekseninde +1)
	if Input.is_action_pressed("sola_git"):
		yon.x -= 1 # Sola git (X ekseninde -1)
	if Input.is_action_pressed("yukari_git"):
		yon.y -= 1 # Yukarı git (Y ekseninde -1, çünkü Godot'ta Y aşağı doğru artar)
	if Input.is_action_pressed("asagi_git"):
		yon.y += 1 # Aşağı git (Y ekseninde +1)

	# 2. Yönü normalleştir.
	# Bu, çapraz giderken (örn: sağ ve yukarı) 2 kat hızlı gitmesini engeller.
	yon = yon.normalized()

	# 3. Hareketi uygula.
	# Godot 3'te KinematicBody2D için sihirli fonksiyon budur.
	# Hızı yön ile çarpar ve karakteri kaydırır, çarparsa durur.
	move_and_slide(yon * hiz)


