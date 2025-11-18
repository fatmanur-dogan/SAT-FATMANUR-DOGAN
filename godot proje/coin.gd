extends Area2D

# _ready fonksiyonu sahne başladığında bir kez çalışır.
func _ready():
	pass # Şimdilik bir şey yapmayacak.

# Bu fonksiyon, "body_entered" sinyali çalıştığında tetiklenir.
# "body" değişkeni, bu alana giren şeydir.
func _on_Coin_body_entered(body):
	
	# Eğer bu alana giren şeyin adı "Player" ise...
	if body.name == "Player":
		
		# Bu sahneyi (yemi) yok et.
		queue_free()


func _on_coin_area_entered(area):
	pass # Replace with function body.
