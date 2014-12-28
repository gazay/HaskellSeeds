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
        readProcess "ls" [name ++ ".cabal"] "" >>= \fileName -> putStrLn $ "Found" ++ fileName
        putStrLn "\n\nConfiguring seed..."
        readProcess "cabal" ["configure"] "" >>= putStrLn
        putStrLn "Seed was configured\n\n"
        putStrLn "Creating Sandbox (just to be sure that it can be built)..."
        readProcess "cabal" ["sandbox", "init"] "" >>= putStrLn
        putStrLn "Sandbox created\n\n"
        putStrLn "Installing seed into sandbox..."
        readProcess "cabal" ["install", "-j"] "" >>= putStrLn
        putStrLn "Installation completed\n\n"
        putStrLn "Building dist..."
        readProcess "cabal" ["sdist"] "" >>= putStrLn
        putStrLn "Distributive was built\n\n"
        putStrLn "Generating docs for seed..."
        readProcess "cabal" (haddockArgs name) "" >>= putStrLn
        return "Success"


pushSeedWithDocs :: [String] -> IO String
pushSeedWithDocs args = do
    pushSeed args >>= printStrLn
    pushDocs args >>= printStrLn

pushSeed :: [String] -> IO String
pushSeed args = undefined


pushDocs :: [String] -> IO String
pushDocs args = undefined
