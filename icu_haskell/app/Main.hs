{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.List (sort, sortBy)
import Data.Text qualified as T (pack, Text)
import Data.Text.ICU qualified as ICU
import Text.Collate qualified as TC

main :: IO ()
main = do
    let xs =
            [ "id"
            , "organization_id"
            , "locked_by"
            , "lock_reasons"
            , "lock_note"
            , "lock_source"
            , "sent_notification_emails"
            , "created_at"
            ] ::
                [String]
    let ys = fmap T.pack xs
    putStrLn "Original data: " >> putStr "\n"
    print xs
    putStrLn "Default sort:" >> putStr "\t"
    print (sort ys)
    putStrLn "Sort by text-icu:" >> putStr "\t"
    print (sortBy myCompare ys)
    putStrLn "Sort by Text.Collate:" >> putStr "\t"
    print (sortBy (TC.collate "en_US") ys)

myCompare :: T.Text -> T.Text -> Ordering
myCompare =
    ICU.collate
        (ICU.collator (ICU.Locale "en_US"))
