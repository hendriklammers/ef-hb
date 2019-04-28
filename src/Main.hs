{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Maybe (fromMaybe)
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Static
import System.Environment (lookupEnv)
import Text.Read (readMaybe)
import User
import Web.Scotty

users :: [User]
users =
    [ User 0 "Tony Stark" "ironman@yahoo.com"
    , User 1 "Bruce Banner" "bb12345@hotmail.com"
    , User 2 "Steve Rogers" "cap_america@hotmail.com"
    , User 3 "Natasha Romanoff" "blackwidow@gmail.com"
    ]

routes :: ScottyM ()
routes = do
    get "/" $ file "./client/dist/index.html"
    get "/api/users" $ json users
    get "/api/users/:id" getUser

getUser :: ActionM ()
getUser = do
    id <- param "id"
    json $ filter (\user -> User.id user == id) users

main :: IO ()
main = do
    port <- fromMaybe 3000 . (readMaybe =<<) <$> lookupEnv "PORT"
    scotty port $ do
        middleware logStdoutDev
        middleware $ staticPolicy (noDots >-> addBase "./client/dist")
        routes
