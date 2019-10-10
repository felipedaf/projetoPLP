import System.Random

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

--gera o array (space) composto por spaceComponent
buildSpace :: SpaceComponent -> SpaceComponent -> SpaceComponent -> [[SpaceComponent]]
buildSpace enemy vacuo player = take 2 (repeat (take 39 (repeat enemy))) ++ take 19 (repeat (take 39 (repeat vacuo))) ++ [ take 19 (repeat vacuo) ++ [player] ++ take 19 (repeat vacuo)]

--gera o toString de cada spaceComponent (componente)
spaceComponentToString :: SpaceComponent -> String 
spaceComponentToString (SpaceComponent {isPlayer = isPlayer, isEnemy = isEnemy, isVacuo = isVacuo, isShot = isShot})
    | (isPlayer == False) && (isEnemy == True) && (isShot == False) && (isVacuo == False) = "V" --enemy    
    | (isPlayer == False) && (isEnemy == True) && (isShot == True)  && (isVacuo == False) = "v" --enemyShot
    | (isPlayer == True) && (isEnemy == False) && (isShot == False) && (isVacuo == False) = "A" --player    
    | (isPlayer == True) && (isEnemy == False) && (isShot == True) && (isVacuo == False) = "o" --playerShot
    | otherwise = " " --vacuo

--gera a repretancao de cada linha, formada por SpaceComponnent (linha)
linesToString :: String -> Int -> Int -> [[SpaceComponent]] -> String
linesToString string line index spaceArray
    | line == 37 = string
    | otherwise = linesToString (string ++ spaceComponentToString ((spaceArray !! index) !! line)) (line + 1) index spaceArray

--gera a representacao do matrix space (matriz)
spaceToString :: [[SpaceComponent]] -> String -> Int -> String
spaceToString spaceArray string index
    | index == 22 = string -- se chegar na ultima linha, retorna a string final
    | otherwise = spaceToString spaceArray (string ++ linesToString "" 0 index spaceArray
        ++ spaceComponentToString ((spaceArray !! index) !! 38) ++ "\n") (index+1)

--faz movimento do player pra esquerda
playerMoveLeft :: [[SpaceComponent]] -> [[SpaceComponent]]
playerMoveLeft space      
    | (getPlayerPosition 0 (space !! 21)) > 0 = (take 21 space) ++ [take ((getPlayerPosition 0 (space !! 21)) - 1) (space !! 21) ++ [generatePlayer] ++ [(space !! 21) !! ((getPlayerPosition 0 (space !! 21)) -1)] ++ drop ((getPlayerPosition 0 (space !! 21)) + 1) (space !! 21)]
    | otherwise = space

--faz movimento do player pra direita
playerMoveRight :: [[SpaceComponent]] -> [[SpaceComponent]]
playerMoveRight space
    | (getPlayerPosition 0 (space !! 21)) < 38 = (take 21 space) ++ [ take ((getPlayerPosition 0 (space !! 21))) (space !! 21) ++ [(space !! 21) !! ((getPlayerPosition 0 (space !! 21)) + 1)] ++ [generatePlayer] ++ drop ((getPlayerPosition 0 (space !! 21)) + 2) (space !! 21)]
    | otherwise = space

--encontra a a posicao do player
getPlayerPosition :: Int -> [SpaceComponent] -> Int
getPlayerPosition _ [] = 0
getPlayerPosition count (x:xs) 
    | (isPlayer x == True) = count
    | otherwise = getPlayerPosition (count + 1) xs

--gera um tiro inimigo na coluna i
enemyshot:: [[SpaceComponent]] -> Int -> [[SpaceComponent]] 
enemyshot space i
    |(isEnemy ((space!!1)!!i)) = take 2 space ++ [take i (space!!2) ++ [generateEnemyShot] ++ drop (i+1) (space!!2)] ++ drop 3 space
    |(isEnemy ((space!!0)!!i)) = take 1 space ++ [take i (space!!1) ++ [generateEnemyShot] ++ drop (i+1) (space!!1)] ++ drop 2 space
    |otherwise = space

-- chama o moveEachES em cada linha
moveEnemyShot :: [[SpaceComponent]] -> Int -> [[SpaceComponent]] 
moveEnemyShot space l
    |l>=0 =  moveEnemyShot(moveEachES space l 38) (l-1)
    |otherwise = space

--chama o downshot para cada elemento da linha
moveEachES :: [[SpaceComponent]] -> Int -> Int -> [[SpaceComponent]]
moveEachES space l c 
    |c >= 0 = (moveEachES (downShot space l c)) l (c-1)
    |otherwise = space

--move o tiro inimigo para baixo na coluna
downShot :: [[SpaceComponent]] -> Int -> Int -> [[SpaceComponent]]
downShot space l c
    | ((isEnemy ((space!!l)!!c)) && (isShot ((space!!l)!!c)) && (l==21)) = take l space  ++ [take c (space!!l) ++ [generateEnemyShot] ++ drop (c+1) (space!!l)]
    | ((isEnemy ((space!!l)!!c)) && (isShot ((space!!l)!!c)) && (l>=0)) = take l space  ++ [take c (space!!(l))++[generateVacuo] ++ drop (c+1) (space!!(l))] ++ [take c (space !! (l+1)) ++ [generateEnemyShot] ++ drop (c+1) (space !! (l+1)) ] ++ drop (l+1) space
    | otherwise = space 

--cria um tiro do player na sua frente
shot :: [[SpaceComponent]] -> [[SpaceComponent]]
shot space = take 20 space ++ [take (getPlayerPosition 0 (space !! 21)) (space!!20) ++ [generatePlayerShot] ++ drop ((getPlayerPosition 0 (space !! 21)) +1) (space!!20)] ++ drop 21 space

--chama o moveEach para cada linha
moveShot :: [[SpaceComponent]] -> Int -> [[SpaceComponent]] 
moveShot space l
    |l<=21 = moveShot(moveEach space l 0) (l+1)
    |otherwise = space

--chama o upshot para cada elemento da linha
moveEach :: [[SpaceComponent]] -> Int -> Int -> [[SpaceComponent]]
moveEach space l c 
    |c <= 38 = (moveEach (upShot space l c)) l (c+1)
    |otherwise = space

--move o tiro aliado para cima na coluna
upShot :: [[SpaceComponent]] -> Int -> Int -> [[SpaceComponent]]
upShot space l c
    | ((isPlayer ((space!!l)!!c)) && (isShot ((space!!l)!!c)) && (l==0)) = [take c (space!!l) ++ [generateVacuo] ++ drop (c+1) (space!!l)] ++ drop (l+1) space
    | ((isPlayer ((space!!l)!!c)) && (isShot ((space!!l)!!c)) && (l>0)) = take (l-1) space  ++ [take c (space!!(l-1))++[ generatePlayerShot] ++ drop (c+1) (space!!(l-1))] ++ [take c (space !! (l)) ++ [generateVacuo] ++ drop (c+1) (space !! (l)) ] ++ drop (l+1) space
    | otherwise = space 



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
    putStrLn "\n \n \n \n \n \n \n \n \n \n \n \n \n" -- quebra de linhas
    putStrLn (spaceToString space "" 0) -- printa o game
    rand <- randomRIO(0, 38)
    input <- getLine 
    if (input == "a") then runGame (playerMoveLeft (moveShot space 0))
    else if (input == "d") then runGame (playerMoveRight (moveShot space 0))
    else if (input == "w") then runGame(shot (moveShot space 0))
    else if (input == "g") then runGame(enemyshot(moveEnemyShot space 21) rand)
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
