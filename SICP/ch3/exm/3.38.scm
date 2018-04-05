;; the solution for ex. 3.38
; here are three process, in bank system
; Peter : (set! balance (+ balance 10))  => 2 actions
; Paul : (set! balance (- balance 20)) => 2 actions
; Mary : (set! balance (- balance (/ balance 2))) => 3 actions

; a).
; 3! = 6 => Peter->Paul->Mary, Peter->Mary->Paul, Paul->Peter->Mary,
;           Paul->Mary->Peter, Mary->Peter->Paul, Mary->Paul->Peter

; b).
; answer is Yes! Because these actions can be mixed

