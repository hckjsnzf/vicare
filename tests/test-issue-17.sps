;;; -*- coding: utf-8 -*-
;;;
;;;Part of: Vicare
;;;Contents: tests for issue 17
;;;Date: Thu Sep  9, 2010
;;;
;;;Abstract
;;;
;;;
;;;
;;;Copyright (c) 2010 Marco Maggi <marco.maggi-ipsu@poste.it>
;;;
;;;This program is free software:  you can redistribute it and/or modify
;;;it under the terms of the  GNU General Public License as published by
;;;the Free Software Foundation, either version 3 of the License, or (at
;;;your option) any later version.
;;;
;;;This program is  distributed in the hope that it  will be useful, but
;;;WITHOUT  ANY   WARRANTY;  without   even  the  implied   warranty  of
;;;MERCHANTABILITY  or FITNESS FOR  A PARTICULAR  PURPOSE.  See  the GNU
;;;General Public License for more details.
;;;
;;;You should  have received  a copy of  the GNU General  Public License
;;;along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;;


(import (rnrs)
  (checks))

(check-set-mode! 'report-failed)
(display "*** testing issue 17\n")

(define epsilon 1e-6)

(define (eq=? a b)
  ;;This is not  the best definition of equality  between floating point
  ;;numbers.
  ;;
  (let ((ra (real-part a))
	(rb (real-part b))
	(ia (imag-part a))
	(ib (imag-part b)))
    (and (< (abs (- ra rb)) epsilon)
	 (< (abs (- ia ib)) epsilon))))

(define bignum0 (expt 2 32))


;;;; fixnum exponent

;;; fixnum base

(check (expt 2 3)		=> 8)
(check (expt 2 -3)		=> 1/8)

(check (expt -2 3)		=> -8)
(check (expt -2 -3)		=> -1/8)

(check (expt 0 3)		=> 0)
(check (expt 0 -3)		=> 0)

(check (expt 3 0)		=> 1)
(check (expt -3 0)		=> 1)

;;; --------------------------------------------------------------------
;;; rational base

(check (expt 2/3 3)		=> 8/27)
(check (expt 2/3 -3)		=> 27/8)

(check (expt -2/3 3)		=> -8/27)
(check (expt -2/3 -3)		=> -27/8)

(check (expt 3/4 0)		=> 1)
(check (expt -3/4 0)		=> 1)

;;; --------------------------------------------------------------------
;;; bignum base

(check (expt bignum0 3)		=> 79228162514264337593543950336)
(check (expt bignum0 -3)	=> 1/79228162514264337593543950336)

(check (expt (- bignum0) 3)	=> -79228162514264337593543950336)
(check (expt (- bignum0) -3)	=> -1/79228162514264337593543950336)

(check (expt bignum0 0)		=> 1)
(check (expt (- bignum0) 0)	=> 1)

;;; --------------------------------------------------------------------
;;; flonum base

(check (expt 2. 3)		=> 8.)
(check (expt 2. -3)		=> 0.125)

(check (expt -2. 3)		=> -8.0)
(check (expt -2. -3)		=> -0.125)

(check (expt 0. 3)		=> 0.)
(check (expt 0. -3)		=> +inf.0)

(check (expt 3. 0)		=> 1.)
(check (expt -3. 0)		=> 1.)

(check (expt 2.3 3)		(=> eq=?) 12.166999999999998)
(check (expt 2.3 -3)		(=> eq=?) 0.08218952905399854)

(check (expt -2.3 3)		(=> eq=?) -12.166999999999998)
(check (expt -2.3 -3)		(=> eq=?) -0.08218952905399854)

(check (expt 3.4 0)		=> 1.)
(check (expt -3.4 0)		=> 1.)

(check (expt +inf.0 2)		=> +inf.0)
(check (expt +inf.0 -2)		=> 0.0)
(check (expt +inf.0 0)		=> +nan.0)

(check (expt -inf.0 2)		=> +inf.0)
(check (expt -inf.0 -2)		=> 0.0)
(check (expt -inf.0 0)		=> +nan.0)

(check (nan? (expt +nan.0 2))	=> #t)
(check (nan? (expt +nan.0 -2))	=> #t)
(check (nan? (expt +nan.0 0))	=> #t)

;;; --------------------------------------------------------------------
;;; complex fixnum base

(check (expt 1+2i 2)		=> -3+4i)
(check (expt 3+4i 5)		=> -237-3116i)

(check (expt +2i 2)		=> -4)
(check (expt +4i 5)		=> +1024i)
(check (expt -2i 2)		=> -4)
(check (expt -4i 5)		=> -1024i)

(check (expt +2i -2)		=> -1/4)
(check (expt +4i -5)		=> -1/1024i)
(check (expt -2i -2)		=> -1/4)
(check (expt -4i -5)		=> +1/1024i)

;;; --------------------------------------------------------------------
;;; complex rational base


;;; --------------------------------------------------------------------
;;; complex bignum base

(check
    (expt (make-rectangular bignum0 bignum0) 3)
  => -158456325028528675187087900672+158456325028528675187087900672i)

(check
    (expt (make-rectangular (- bignum0) bignum0) 3)
  => 158456325028528675187087900672+158456325028528675187087900672i)

(check
    (expt (make-rectangular bignum0 (- bignum0)) 3)
  => -158456325028528675187087900672-158456325028528675187087900672i)

(check
    (expt (make-rectangular (- bignum0) (- bignum0)) 3)
  => 158456325028528675187087900672-158456325028528675187087900672i)

;;

(check
    (expt (make-rectangular bignum0 bignum0) -3)
  => -1/316912650057057350374175801344-1/316912650057057350374175801344i)

(check
    (expt (make-rectangular (- bignum0) bignum0) -3)
  => 1/316912650057057350374175801344-1/316912650057057350374175801344i)

(check
    (expt (make-rectangular bignum0 (- bignum0)) -3)
  => -1/316912650057057350374175801344+1/316912650057057350374175801344i)

(check
    (expt (make-rectangular (- bignum0) (- bignum0)) -3)
  => 1/316912650057057350374175801344+1/316912650057057350374175801344i)

;;

(check
    (expt (make-rectangular 0 bignum0) 3)
  => -79228162514264337593543950336i)

(check
    (expt (make-rectangular 0 bignum0) -3)
  => +1/79228162514264337593543950336i)

(check
    (expt (make-rectangular 0 (- bignum0)) 3)
  => +79228162514264337593543950336i)

(check
    (expt (make-rectangular 0 (- bignum0)) -3)
  => -1/79228162514264337593543950336i)

;;; --------------------------------------------------------------------
;;; complex flonum base

(check (expt 1.+2.i 2)		=> -3.+4.i)
(check (expt 3.+4.i 5)		=> -237.-3116.i)

(check (expt +2.i 2)		=> -4.+0.i)
(check (expt +4.i 5)		=> +1024.i)
(check (expt -2.i 2)		=> -4.+0.i)
(check (expt -4.i 5)		=> -1024.i)

(check (expt +2.i -2)		(=> eq=?) (inexact -1/4))
(check (expt +4.i -5)		(=> eq=?) (inexact -1/1024i))
(check (expt -2.i -2)		(=> eq=?) (inexact -1/4))
(check (expt -4.i -5)		(=> eq=?) (inexact +1/1024i))

(check (expt +inf.0+2.i 2)	=> +inf.0+inf.0i)
(check (expt +2.+inf.0i 2)	=> +inf.0+inf.0i)
(check (expt +inf.0+2.i 0)	=> +inf.0+inf.0i)
(check (expt +2.+inf.0i 0)	=> +inf.0+inf.0i)

(check (expt -inf.0+2.i 2)	=> -inf.0-inf.0i)
(check (expt +2.-inf.0i 2)	=> -inf.0-inf.0i)
(check (expt -inf.0+2.i 0)	=> -inf.0-inf.0i)
(check (expt +2.-inf.0i 0)	=> -inf.0-inf.0i)

(check (nan? (expt +nan.0+2.i 2))	=> #t)
(check (nan? (expt +2.+nan.0i 2))	=> #t)
(check (nan? (expt +nan.0+2.i 0))	=> #t)
(check (nan? (expt +2.+nan.0i 0))	=> #t)


;;;; rational exponent

;;; --------------------------------------------------------------------
;;; fixnum base

;;; --------------------------------------------------------------------
;;; rational base

;;; --------------------------------------------------------------------
;;; bignum base

;;; --------------------------------------------------------------------
;;; flonum base

;;; --------------------------------------------------------------------
;;; complex fixnum base

;;; --------------------------------------------------------------------
;;; complex rational base

;;; --------------------------------------------------------------------
;;; complex bignum base

;;; --------------------------------------------------------------------
;;; complex flonum base


;;;; bignum exponent

;;; fixnum base

(check (expt  0 (+ 3 bignum0))	=> 0)
(check (expt  1 (+ 3 bignum0))	=> 1)
(check (expt  1 (- bignum0))	=> 1)
(check (expt -1 (+ 3 bignum0))	=> -1) ;odd positive exponent
(check (expt -1 (+ 4 bignum0))	=> +1) ;even positive exponent
(check (expt -1 (- -1 bignum0))	=> -1) ;odd negative exponent
(check (expt -1 (- bignum0))	=> 1) ;even negative exponent

(check
    (guard (E ((assertion-violation? E)
	       #t)
	      (else #f))
      ;;result is too big to compute
      (expt 2 bignum0))
  => #t)

;; (check (expt 2 (+  3 bignum0))	=> 8)
;; (check (expt 2 (- -3 bignum0))	=> -8)

;; (check (expt -2 (+  3 bignum0))	=> -8)
;; (check (expt -2 (- -3 bignum0))	=> 8)

;; (check (expt 0 (+  3 bignum0))	=> 0)
;; (check (expt 0 (- -3 bignum0))	=> 0)

(check
    (guard (E ((assertion-violation? E)
	       #t)
	      (else #f))
      ;;result is too big to compute
      (expt 2 (make-rectangular bignum0 bignum0)))
  => #t)

;;; --------------------------------------------------------------------
;;; rational base

;;; --------------------------------------------------------------------
;;; bignum base

;;; --------------------------------------------------------------------
;;; flonum base

;;When the  exponent is a bignum:  EXPT computes the result  only if the
;;base is 0, +1, -1 or NaN.
;;
;; (check
;;     (expt +nan.0 (expt 2 32))
;;   => +nan.0)

;;; --------------------------------------------------------------------
;;; complex fixnum base

;;; --------------------------------------------------------------------
;;; complex rational base

;;; --------------------------------------------------------------------
;;; complex bignum base

;;; --------------------------------------------------------------------
;;; complex flonum base


;;;; flonum exponent

;;; fixnum base

(check (expt 2 +nan.0)		=> +nan.0)
(check (expt 2 +inf.0)		=> +inf.0)
(check (expt 2 -inf.0)		=> 0.)

(check (expt 2 3.)		=> 8.)
(check (expt 2 -3.)		=> (inexact 1/8))

(check (expt -2 3.)		=> -8.)
(check (expt -2 -3.)		=> (inexact -1/8))

(check (expt 0 3.)		=> 0.)
(check (expt 0 -3.)		=> +inf.0)

(check (expt 3 0.)		=> 1.)
(check (expt -3 0.)		=> 1.)

;;; --------------------------------------------------------------------
;;; rational base


;;; --------------------------------------------------------------------
;;; bignum base


;;; --------------------------------------------------------------------
;;; flonum base

;; (check (expt 1.+2.i 2.)		(=> eq=?) -3.+4.i)
;; (check (expt 3.+4.i 5.)		(=> eq=?) -237.-3116.i)

;; (check
;;     (let ((r (expt +i +inf.0)))
;;       (list (nan? (real-part r))
;; 	    (nan? (imag-part r))))
;;   => '(#t #t))

(check (expt 0.0 0.0)		=> 1.0)
(check (expt 0.0 1.0)		=> 0.0)

;;; --------------------------------------------------------------------
;;; complex fixnum base

;;; --------------------------------------------------------------------
;;; complex rational base

;;; --------------------------------------------------------------------
;;; complex bignum base

;;; --------------------------------------------------------------------
;;; complex flonum base


;;;; complex exponent

;;; fixnum base

(check (expt 2 +3+4i)		(=> eq=?) -7.461496614688567+2.8854927255134477i)
(check (expt 2 +3-4i)		(=> eq=?) -7.461496614688567-2.8854927255134477i)
(check (expt 2 -3+4i)		(=> eq=?) -0.11658588460450892+0.045085823836147634i)
(check (expt 2 -3-4i)		(=> eq=?) -0.11658588460450892-0.045085823836147634i)

(check (expt -2 +3+4i)		(=> eq=?) 2.6020793185113498e-5-1.0062701000215989e-5i)
(check (expt -2 +3-4i)		(=> eq=?) 2139593.9522266407+827418.82808724i)
(check (expt -2 -3+4i)		(=> eq=?) 4.0657489351739836e-7-1.5722970312837445e-7i)
(check (expt -2 -3-4i)		(=> eq=?) 33431.15550354123+12928.419188863143i)

(check (expt 0 +3+4i)		=> 0)
(check (expt 0 +3-4i)		=> 0)
(check (expt 0 -3+4i)		=> 0)
(check (expt 0 -3-4i)		=> 0)

;;; --------------------------------------------------------------------
;;; rational base

;;; --------------------------------------------------------------------
;;; bignum base

;;; --------------------------------------------------------------------
;;; flonum base

;;; --------------------------------------------------------------------
;;; complex fixnum base

;;; --------------------------------------------------------------------
;;; complex rational base

;;; --------------------------------------------------------------------
;;; complex bignum base

;;; --------------------------------------------------------------------
;;; complex flonum base


;;;; done

(check-report)

;;; end of file
