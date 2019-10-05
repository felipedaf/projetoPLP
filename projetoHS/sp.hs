data SpaceComponent = SpaceComponent  {
    isEnemy :: Bool,
    isVacuo :: Bool,
    isShot :: Bool,
    toString :: String
} deriving (Show, Eq)

generateEnemy :: SpaceComponent
generateEnemy = SpaceComponent {
	isEnemy = True,
	isVacuo = False,
    isShot = False,
    toString = "V"
};

generateEnemyShot :: SpaceComponent
generateEnemyShot = SpaceComponent {
	isEnemy = True,
	isVacuo = False,
    isShot = True,
    toString = "v"
};

generatePlayer :: SpaceComponent
generatePlayer = SpaceComponent {
	isEnemy = False,
	isVacuo = False,
	isShot = False,
    toString = "A"
};

generatePlayerShot :: SpaceComponent
generatePlayerShot = SpaceComponent {
	isEnemy = False,
	isVacuo = False,
	isShot = True,
    toString = "o"
};

generateVacuo :: SpaceComponent
generateVacuo = SpaceComponent {
	isEnemy = False,
	isVacuo = True,
    isShot = False,
    toString = " "
};

buildSpace :: SpaceComponent -> SpaceComponent -> SpaceComponent -> [[String]]
buildSpace enemy vacuo player = take 3 (repeat (take 9 (repeat (toString enemy)))) ++ take 5 (repeat (take 9 (repeat (toString vacuo)))) ++ [[(toString vacuo), (toString vacuo), (toString vacuo), (toString vacuo), (toString player), (toString vacuo), (toString vacuo), (toString vacuo), (toString vacuo)]]

main :: IO ()
main = do
    let enemy = generateEnemy
    let player = generatePlayer
    let vacuo = generateVacuo
    let space = buildSpace enemy vacuo player
    print (show space)
    return ()