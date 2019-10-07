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
    | index == 22 = string --se chegar na ultima linha, retorna a string final
    | otherwise = spaceToString spaceArray (string ++ (spaceComponentToString ((spaceArray !! index) !! 0) 
        ++ spaceComponentToString ((spaceArray !! index) !! 1) 
        ++ spaceComponentToString ((spaceArray !! index) !! 2) 
        ++ spaceComponentToString ((spaceArray !! index) !! 3) 
        ++ spaceComponentToString ((spaceArray !! index) !! 4) 
        ++ spaceComponentToString ((spaceArray !! index) !! 5) 
        ++ spaceComponentToString ((spaceArray !! index) !! 6) 
        ++ spaceComponentToString ((spaceArray !! index) !! 7) 
        ++ spaceComponentToString ((spaceArray !! index) !! 8) 
        ++ spaceComponentToString ((spaceArray !! index) !! 9) 
        ++ spaceComponentToString ((spaceArray !! index) !! 10) 
        ++ spaceComponentToString ((spaceArray !! index) !! 11) 
        ++ spaceComponentToString ((spaceArray !! index) !! 12) 
        ++ spaceComponentToString ((spaceArray !! index) !! 13) 
        ++ spaceComponentToString ((spaceArray !! index) !! 14) 
        ++ spaceComponentToString ((spaceArray !! index) !! 15) 
        ++ spaceComponentToString ((spaceArray !! index) !! 16) 
        ++ spaceComponentToString ((spaceArray !! index) !! 17) 
        ++ spaceComponentToString ((spaceArray !! index) !! 18) 
        ++ spaceComponentToString ((spaceArray !! index) !! 19) 
        ++ spaceComponentToString ((spaceArray !! index) !! 20) 
        ++ spaceComponentToString ((spaceArray !! index) !! 21) 
        ++ spaceComponentToString ((spaceArray !! index) !! 22) 
        ++ spaceComponentToString ((spaceArray !! index) !! 23) 
        ++ spaceComponentToString ((spaceArray !! index) !! 24) 
        ++ spaceComponentToString ((spaceArray !! index) !! 25) 
        ++ spaceComponentToString ((spaceArray !! index) !! 26) 
        ++ spaceComponentToString ((spaceArray !! index) !! 27) 
        ++ spaceComponentToString ((spaceArray !! index) !! 28) 
        ++ spaceComponentToString ((spaceArray !! index) !! 29) 
        ++ spaceComponentToString ((spaceArray !! index) !! 30) 
        ++ spaceComponentToString ((spaceArray !! index) !! 31) 
        ++ spaceComponentToString ((spaceArray !! index) !! 32) 
        ++ spaceComponentToString ((spaceArray !! index) !! 33) 
        ++ spaceComponentToString ((spaceArray !! index) !! 34) 
        ++ spaceComponentToString ((spaceArray !! index) !! 35) 
        ++ spaceComponentToString ((spaceArray !! index) !! 36) 
        ++ spaceComponentToString ((spaceArray !! index) !! 37) 
        ++ spaceComponentToString ((spaceArray !! index) !! 38)) ++ "\n") (index+1)

-- gera o array (space) composto por spaceComponent
buildSpace :: SpaceComponent -> SpaceComponent -> SpaceComponent -> [[SpaceComponent]]
buildSpace enemy vacuo player = take 3 (repeat (take 39 (repeat enemy))) ++ take 18 (repeat (take 39 (repeat vacuo))) ++ [ take 19 (repeat vacuo) ++ [player] ++ take 19 (repeat vacuo)]

main :: IO ()
main = do
    let enemy = generateEnemy
    let player = generatePlayer
    let vacuo = generateVacuo
    let space = buildSpace enemy vacuo player

    runGame space

    return ()

runGame :: [[SpaceComponent]] -> IO()
runGame space = do
    putStrLn (spaceToString space "" 0)
    input <- getLine
--    | (input == 'w') = playerShot 
--    | (input == 'a') = playerMove
--    | (input == 'd') = playerMove
    if (input == "s") then endGame
    else runGame space

endGame = do
    putStrLn "\n \n \n \n \n \n \n \n \n \n \n \n \n"
    putStrLn "               _____                  "
    putStrLn "            ,-       -.               "
    putStrLn "           / o       o \\             "  
    putStrLn "          /   \\     /   \\           "
    putStrLn "         /     )- -(     \\           "       
    putStrLn "        /     ( 6 6 )     \\          "
    putStrLn "       /       \\   /       \\        "
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