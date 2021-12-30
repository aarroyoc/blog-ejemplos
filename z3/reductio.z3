(declare-const p Bool)
(define-fun conjecture () Bool
    (or p (not p))
)
(assert (not conjecture))
(check-sat)