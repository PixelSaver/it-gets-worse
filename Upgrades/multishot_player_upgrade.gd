class_name MultishotPlayerStrategy
extends BasePlayerStrategy

@export var multishot_increase : float = 1.0

func apply_upgrade(player: Player):
	player.gun.multishot += multishot_increase
