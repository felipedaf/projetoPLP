data SpaceComponent = SpaceComponent {
	isEnemy :: Bool,
	isVacuo :: Bool,
	isShot :: Bool
}
type SpaceMatrix = [[SpaceComponent]]

generateEnemy :: SpaceComponent
generateEnemy = SpaceComponent {
	isEnemy = True,
	isVacuo = False,
	isShot = False
}

generateEnemyShot :: SpaceComponent
generateEnemyShot = SpaceComponent {
	isEnemy = True,
	isVacuo = False,
	isShot = True
}

generatePlayer :: SpaceComponent
generatePlayer = SpaceComponent {
	isEnemy = False,
	isVacuo = False,
	isShot = False
}

generatePlayerShot :: SpaceComponent
generatePlayerShot = SpaceComponent {
	isEnemy = False,
	isVacuo = False,
	isShot = True
}

generateVacuo :: SpaceComponent
generateVacuo = SpaceComponent {
	isEnemy = False,
	isVacuo = True,
	isShot = False
}


main :: IO ()
main = do
    b <- getLine
