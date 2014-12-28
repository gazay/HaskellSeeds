--
-- Copyright (c) 2014 gazay
-- MIT License
--
import Prelude
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
                                buildSeed args >>= putStrLn
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
buildSeed args =
    let name = args !! 0
    in
      do
        putStrLn "Looking for cabal file..."
        cabalFile <- readProcess "ls" [name ++ ".cabal"] ""
        putStrLn cabalFile
        putStrLn $ "Found " ++ cabalFile
        putStrLn "Creating Sandbox (just to be sure that it can be built)..."
        result1 <- readProcess "cabal" ["sandbox", "init"] ""
        putStrLn result1
        putStrLn "Sandbox created"
        putStrLn "Building dist..."
        result2 <- readProcess "cabal" ["dist"] ""
        putStrLn result2
        putStrLn "Distributive was built"
        putStrLn "Installing seed into sandbox..."
        result3 <- readProcess "cabal" ["install", "-j"] ""
        putStrLn result4
        putStrLn "Installation completed"
        putStrLn "Generating docs for seed..."
        result4 <- readProcess "cabal" (haddockArgs name) ""
        return result4


pushSeedWithDocs :: [String] -> IO String
pushSeedWithDocs = undefined
