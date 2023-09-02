module Main where

import Data.List (sort, sortBy)
import Data.Text qualified as T (pack, Text)
import Data.Text.ICU qualified as ICU

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
    print xs
    print (sort ys)
    print (sortBy myCompare ys)

myCompare :: T.Text -> T.Text -> Ordering
myCompare =
    ICU.collate
        (ICU.collator (ICU.Locale "en_US"))
