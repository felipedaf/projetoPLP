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

linesToString :: String -> Int -> Int -> [[SpaceComponent]] -> String
linesToString string line index spaceArray
    | line == 37 = string
    | otherwise = linesToString (string ++ spaceComponentToString ((spaceArray !! index) !! line)) (line + 1) index spaceArray

--gera a representacao em string do array (space) 
spaceToString :: [[SpaceComponent]] -> String -> Int -> String
spaceToString spaceArray string index
    | index == 22 = string --se chegar na ultima linha, retorna a string final
    | otherwise = spaceToString spaceArray (string ++ linesToString "" 0 index spaceArray
        ++ spaceComponentToString ((spaceArray !! index) !! 38) ++ "\n") (index+1)

-- gera o array (space) composto por spaceComponent
buildSpace :: SpaceComponent -> SpaceComponent -> SpaceComponent -> [[SpaceComponent]]
buildSpace enemy vacuo player = take 3 (repeat (take 39 (repeat enemy))) ++ take 18 (repeat (take 39 (repeat vacuo))) ++ [ take 19 (repeat vacuo) ++ [player] ++ take 19 (repeat vacuo)]

playerMoveLeft :: [[SpaceComponent]] -> [[SpaceComponent]]
playerMoveLeft space 
    | (getPlayerPosition 0 (space !! 21)) > 0 = (take 21 space) ++ [take ((getPlayerPosition 0 (space !! 21)) - 1) (repeat generateVacuo) ++ [generatePlayer] ++ take (39 - (getPlayerPosition 0 (space !! 21))) (repeat generateVacuo)]
    | otherwise = space

playerMoveRight :: [[SpaceComponent]] -> [[SpaceComponent]]
playerMoveRight space
    | (getPlayerPosition 0 (space !! 21)) < 38 = (take 21 space) ++ [take ((getPlayerPosition 0 (space !! 21)) + 1) (repeat generateVacuo) ++ [generatePlayer] ++ take (38 - (getPlayerPosition 0 (space !! 21))) (repeat generateVacuo)]
    | otherwise = space
    
getPlayerPosition :: Int -> [SpaceComponent] -> Int
getPlayerPosition _ [] = 0
getPlayerPosition count (x:xs) 
    | (isPlayer x == True) = count
    | otherwise = getPlayerPosition (count + 1) xs   

endGame = do
    putStrLn "\n \n \n \n \n \n \n \n \n \n \n \n \n"
    putStrLn "               _____                  "
    putStrLn "            ,-       -.               "
    putStrLn "           / o       o \\             "  
    putStrLn "          /   \\     /   \\           "
    putStrLn "         /     )- -(     \\           "       
    putStrLn "        /     ( 6 6 )     \\          "
    putStrLn "       /       \\ ₆ /       \\        "
    putStrLn "      /         )=(         \\        "
    putStrLn "     /   o   .-- - --.   o   \\       "
    putStrLn "    /    I  /  -   -  \\  I    \\     "
    putStrLn ".--(    (_}y/\\       /\\y{_)    )--. "
    putStrLn "(    .___l\\/__\\_____/__\\/l___,    )"
    putStrLn " \\          FIM DE JOGO            / "
    putStrLn " -._       o O o O o O o      _,-     "
    putStrLn "     `--Y--.___________.--Y--'        "
    putStrLn "        |==.___________.==|           "
    putStrLn "        `==.___________.=='           "
    putStrLn " "

runGame :: [[SpaceComponent]] -> IO()
runGame space = do
    putStrLn ((take 9 (repeat "\n")) ++ spaceToString space "" 0) -- printa o game
    input <- getLine 
    if (input == "a") then runGame (playerMoveLeft space)
    else if (input == "d") then runGame (playerMoveRight space)
    else if (input == "s") then endGame
    else runGame space

main :: IO ()
main = do
    let enemy = generateEnemy
    let player = generatePlayer
    let vacuo = generateVacuo
    let space = buildSpace enemy vacuo player

    runGame space

    return ()
