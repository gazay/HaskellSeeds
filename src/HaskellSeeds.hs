--
-- Copyright (c) 2014 gazay
-- MIT License
--
import System.Environment

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

buildSeed :: [String] -> IO String
buildSeed = undefined

pushSeedWithDocs :: [String] -> IO String
pushSeedWithDocs = undefined
