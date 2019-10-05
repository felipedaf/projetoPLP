data SpaceComponent = SpaceComponent  {
    isPlayer :: Bool,
    isEnemy :: Bool,
    isVacuo :: Bool,
    isShot :: Bool
} deriving (Show, Eq)

generateEnemy :: SpaceComponent
generateEnemy = SpaceComponent {
    isPlayer = False,
    isEnemy = True,
	isVacuo = False,
    isShot = False
};

generateEnemyShot :: SpaceComponent
generateEnemyShot = SpaceComponent {
    isPlayer = False,
    isEnemy = True,
	isVacuo = False,
    isShot = True
};

generatePlayer :: SpaceComponent
generatePlayer = SpaceComponent {
    isPlayer = True,
    isEnemy = False,
	isVacuo = False,
    isShot = False
};

generatePlayerShot :: SpaceComponent
generatePlayerShot = SpaceComponent {
    isPlayer = True,
    isEnemy = False,
	isVacuo = False,
    isShot = True
};

generateVacuo :: SpaceComponent
generateVacuo = SpaceComponent {
    isPlayer = False,
    isEnemy = False,
	isVacuo = True,
    isShot = False
};

--gera a representacao em string dos spaceComponents
spaceComponentToString :: SpaceComponent -> String 
spaceComponentToString (SpaceComponent {isPlayer = isPlayer, isEnemy = isEnemy, isVacuo = isVacuo, isShot = isShot})
    | (isPlayer == False) && (isEnemy == True) && (isShot == False) && (isVacuo == False) = "V" --enemy    
    | (isPlayer == False) && (isEnemy == True) && (isShot == True)  && (isVacuo == False) = "v" --enemyShot
    | (isPlayer == True) && (isEnemy == False) && (isShot == False) && (isVacuo == False) = "A" --player    
    | (isPlayer == True) && (isEnemy == False) && (isShot == True) && (isVacuo == False) = "o" --playerShot
    | otherwise = " " --vacuo

--gera a representacao em string do array (space) 
spaceToString :: [[SpaceComponent]] -> String -> Int -> String
spaceToString spaceArray string index
    | index == 9 = string --se chegar na ultima linha, retorna a string final
    | otherwise = spaceToString spaceArray (string ++ (spaceComponentToString ((spaceArray !! index) !! 0) 
        ++ spaceComponentToString ((spaceArray !! index) !! 1) 
        ++ spaceComponentToString ((spaceArray !! index) !! 2) 
        ++ spaceComponentToString ((spaceArray !! index) !! 3) 
        ++ spaceComponentToString ((spaceArray !! index) !! 4) 
        ++ spaceComponentToString ((spaceArray !! index) !! 5) 
        ++ spaceComponentToString ((spaceArray !! index) !! 6) 
        ++ spaceComponentToString ((spaceArray !! index) !! 7) 
        ++ spaceComponentToString ((spaceArray !! index) !! 8)) ++ "\n") (index+1)

-- gera o array (space) composto por spaceComponent
buildSpace :: SpaceComponent -> SpaceComponent -> SpaceComponent -> [[SpaceComponent]]
buildSpace enemy vacuo player = take 3 (repeat (take 9 (repeat enemy))) ++ take 5 (repeat (take 9 (repeat vacuo))) ++ [[vacuo, vacuo, vacuo, vacuo, player, vacuo, vacuo, vacuo, vacuo]]

main :: IO ()
main = do
    let enemy = generateEnemy
    let player = generatePlayer
    let vacuo = generateVacuo
    let space = buildSpace enemy vacuo player
    print (spaceToString space "" 0)

    return ()