{-# LANGUAGE DeriveGeneric #-}

module User where

import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics

data User = User
    { id :: Int
    , name :: String
    , email :: String
    } deriving (Show, Generic)

instance ToJSON User

instance FromJSON User
