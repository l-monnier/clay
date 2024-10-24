{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
module Clay.Pseudo where

import Data.Text (Text)

import Clay.Render (renderSelector, renderRefinement)
import Clay.Selector

import qualified Data.Text.Lazy as Lazy

-- List of specific pseudo classes, from:
-- https://developer.mozilla.org/en-US/docs/CSS/Pseudo-classes

-- * Pseudo elements

after, before, firstLetter, firstLine, selection, backdrop :: Refinement

after       = "::after"
before      = "::before"
firstLetter = "::first-letter"
firstLine   = "::first-line"
selection   = "::selection"
backdrop    = "::backdrop"

-- * Pseudo classes
link, visited, active, hover, focus, firstChild, lastChild :: Refinement

link       = ":link"
visited    = ":visited"
active     = ":active"
hover      = ":hover"
focus      = ":focus"
firstChild = ":first-child"
lastChild  = ":last-child"

checked, default_, disabled, empty, enabled, firstOfType, indeterminate,
  inRange, invalid, lastOfType, onlyChild, onlyOfType, optional,
  outOfRange, required, root, target, valid :: Refinement

checked       = ":checked"
default_      = ":default"
disabled      = ":disabled"
empty         = ":empty"
enabled       = ":enabled"
firstOfType   = ":first-of-type"
indeterminate = ":indeterminate"
inRange       = ":in-range"
invalid       = ":invalid"
lastOfType    = ":last-of-type"
onlyChild     = ":only-child"
onlyOfType    = ":only-of-type"
optional      = ":optional"
outOfRange    = ":out-of-range"
required      = ":required"
root          = ":root"
target        = ":target"
valid         = ":valid"

lang, nthChild, nthLastChild, nthLastOfType, nthOfType :: Text -> Refinement

lang          n = func "lang"             [n]
nthChild      n = func "nth-child"        [n]
nthLastChild  n = func "nth-last-child"   [n]
nthLastOfType n = func "nth-last-of-type" [n]
nthOfType     n = func "nth-of-type"      [n]

-- | The 'not' pseudo selector can be applied to both a 'Refinement'
--
-- > input # not checked
-- 
-- or a 'Selector'
--
-- > not p

class Not a where
  not :: a -> Refinement

instance Not Selector where
  not r = func "not" [Lazy.toStrict (renderSelector r)]

instance Not Refinement where
  not r = func "not" (Lazy.toStrict <$> renderRefinement r)
