--
-- Copyright (c) 2014 gazay
-- MIT License
--
import System.Environment
import System.Process

-- | 'main' runs the main program
main :: IO ()
main = getArgs >>= runTask

helpMessage :: String
helpMessage = unlines [ "HaskellSeeds"
                      , " version: 0.1.0.0"
                      , " repo:    https://github.com/gazay/HaskellSeeds"
                      , ""
                      , "Help message:"
                      , ""
                      , " build - builds your library or executable with cabal install."
                      , "         By default runs hlint and builds documentation with haddock"
                      , "         for uploading to hackage"
                      , " push  - uploads your library or executable to hackage. Uploads documentation by default"
                      , " help  - shows this message"
                      ]

runTask :: [String] -> IO ()
runTask ("help":args)   = putStrLn helpMessage
runTask ("--help":args) = putStrLn helpMessage
runTask ("-h":args)     = putStrLn helpMessage
runTask ("build":args)  = do
                                result <- buildSeed args
                                putStrLn result
runTask ("push":args)   = do
                                result <- pushSeedWithDocs args
                                putStrLn result
runTask _               = putStrLn "Command is not supported"

haddockArgs :: String -> [String]
haddockArgs libName = [ "haddock"
                      , "--hyperlink-source"
                      , "--html-location='http://hackage.haskell.org/package/" ++ libName ++ "/docs'"
                      , "--contents-location='http://hackage.haskell.org/package/" ++ libName ++ "'"
                      ]

buildSeed :: [String] -> IO String
buildSeed = do
    putStrLn "Looking for cabal file..."
    cabalFile <- readProcess "ls" ["*.cabal"] ""
    putStrLn cabalFile
    putStrLn "Found " ++ cabalFile
    putStrLn "Creating Sandbox..."
    result1 <- readProcess "cabal" ["sandbox", "init"] ""
    putStrLn result1
    putStrLn "Sandbox created"
    putStrLn "Installing seed into sandbox..."
    result2 <- readProcess "cabal" ["install", "-j"] ""
    putStrLn result2
    putStrLn "Installation completed"
    putStrLn "Generating docs for seed..."
    result3 <- readProcess "cabal" haddockArgs(cabalFile) ""
    return result3


pushSeedWithDocs :: [String] -> IO String
pushSeedWithDocs = undefined
