class_name PnjState
extends State

var pnj: Pnj # Pnj class

func _ready() -> void:
	
	await owner.ready # Attendre que le parent soit chargé
	
	pnj = owner as Pnj # Pour pouvoir accéder au propriétés du pnj
	
	assert(pnj != null) # Évite des erreurs, comme un parent non-existant
