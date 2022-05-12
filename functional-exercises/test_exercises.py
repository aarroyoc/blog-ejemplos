import unittest
import functools

def existe(lis, x):
    return functools.reduce(lambda a,b: a or b, map(lambda y: x == y, lis))

def dignum(lis):
    nums = zip(lis[::-1], range(len(lis)))
    nums = map(lambda t: t[0]*10**t[1], nums)
    return functools.reduce(lambda x,y: x+y, nums)

def maxlis(lis):
    return functools.reduce(lambda x,y: x if x > y else y, lis)

def count_1(lis, x):
    return len(list(filter(lambda y: x == y, lis)))

def count_2(lis, x):
    return functools.reduce(lambda a,b: a+b, map(lambda y: 1 if x == y else 0, lis))

def dividePares(lis):
    pares = filter(lambda x: x%2 == 0, lis)
    return list(map(lambda x: x / 2, pares))

def enRango(a, b, lis):
    return list(filter(lambda x: a <= x <= b, lis))

def cuentaPositivos(lis):
    return len(list(filter(lambda x: x > 0, lis)))

def mayor(lis, n):
    return list(filter(lambda x: x > n, lis))

def divideParesLC(lis):
    return [n / 2 for n in lis if n % 2 == 0]

def enRangoLC(a, b, lis):
    return [n for n in lis if a <= n <= b]

def cuentaPositivosLC(lis):
    return len([n for n in lis if n > 0])

def pitagoras(n):
    return [(x,y,z) for z in range(n+1) for y in range(z) for x in range(y) if x**2 + y**2 == z**2]

class FunctionalTest(unittest.TestCase):

    def test_one(self):
        self.assertTrue(existe([1,2,3], 1))
        self.assertFalse(existe([1,2,3], 4))

    def test_two(self):
        self.assertEqual(dignum([1,2,3,4]), 1234)

    def test_three(self):
        self.assertEqual(maxlis([-5, 6, 7, -4, 3, 0]), 7)

    def test_four(self):
        lis = [1,2,6,1,3,5,1,3,5]
        self.assertEqual(count_1(lis, 3), 2)
        self.assertEqual(count_2(lis, 3), 2)

    def test_five(self):
        self.assertEqual(dividePares([0,2,1,7,8,56,17,18]), [0,1,4,28,9])

    def test_six(self):
        self.assertEqual(enRango(5, 10, [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]), [5,6,7,8,9,10])

    def test_seven(self):
        self.assertEqual(cuentaPositivos([0,1,-3,-2,8,-1,6]), 3)

    def test_eight(self):
        self.assertEqual(mayor([1,5,7,9,1,2,12,23,45,5,8], 4), [5,7,9,12,23,45,5,8])

    def test_nine(self):
        self.assertEqual(divideParesLC([0,2,1,7,8,56,17,18]), [0,1,4,28,9])

    def test_ten(self):
        self.assertEqual(enRangoLC(5, 10, [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]), [5,6,7,8,9,10])

    def test_eleven(self):
        self.assertEqual(cuentaPositivosLC([0,1,-3,-2,8,-1,6]), 3)

    def test_twelve(self):
        self.assertEqual(pitagoras(20), [(3,4,5), (6,8,10), (5,12,13), (9,12,15), (8,15,17), (12,16,20)])
