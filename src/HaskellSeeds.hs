--
-- Copyright (c) 2014 gazay
-- MIT License
--
import System.Environment

-- | 'main' runs the main program
main :: IO ()
main = getArgs >>= print . doSome . head

doSome = ("Boom! " ++)
