import Control.Monad
import Control.Monad.ST
import qualified Data.Array.ST as ST
import Data.STRef

bubblesort :: [Int] -> [Int]
bubblesort xs = runST $ do
    let l = length xs
    temp <- newSTRef $ head xs
    array <- ST.newListArray (0,l-1) xs :: ST s (ST.STArray s Int Int)

    forM_ [0..l] $ \i -> do
        forM_ [1..(l-1)] $ \j -> do
            prev <- ST.readArray array (j-1)
            actual <- ST.readArray array j    
            if prev > actual then do
                writeSTRef temp prev
                ST.writeArray array (j-1) actual
                t <- readSTRef temp
                ST.writeArray array j t
            else do
                return ()

    ST.getElems array
            
main :: IO ()
main = do
    let orden = bubblesort [3,4,1,2]            
    putStrLn ("Orden: "++(show orden))
