extends Control


func bar_update(health, stamina):
	$Health.value = 100 - health
	$Stamina.value = 100 - stamina

