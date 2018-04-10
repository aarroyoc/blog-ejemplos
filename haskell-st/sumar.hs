import Data.STRef
import Control.Monad
import Control.Monad.ST

sumar :: Num a => [a] -> a
sumar xs = runST $ do
    n <- newSTRef 0
    
    forM_ xs $ \x -> do
        modifySTRef n $ \y -> x+y 
    
    readSTRef n

main :: IO ()
main = do
    putStrLn "Suma imperativa"
    let x = sumar [1,2,3,4,5,6,7,8,9]
    putStrLn ("Suma: "++(show x))
