--
-- Copyright (c) 2014 gazay
-- MIT License
--
import System.Environment

-- | 'main' runs the main program
main :: IO ()
main = getArgs >>= runTask

runTask :: [String] -> IO ()
runTask ("help":args)   = print helpMessage
runTask ("--help":args) = print helpMessage
runTask ("-h":args)     = print helpMessage
runTask ("build":args)  = do
                                result <- buildSeed args
                                print result
runTask ("push":args)   = do
                                result <- pushSeedWithDocs args
                                print result
runTask _               = print "Command is not supported"


