;;;; restas-ironclad.lisp
;;;;
;;;; This file is part of the RESTAS library, released under Lisp-LGPL.
;;;; See file COPYING for details.
;;;;
;;;; Author: Moskvitin Andrey <archimag@gmail.com>


(in-package #:restas.optional)

(defun calc-digest-sum (val digest)
  (ironclad:byte-array-to-hex-string (ironclad:digest-sequence digest
                                                               (string-to-octets val))))

(defun/export calc-md5-sum (val)
  "Calc md5 sum of the val (string)"
  (calc-digest-sum val :md5))
  
(defun/export calc-sha1-sum (val)
  "Calc sha1 sum of the val (string)"
  (calc-digest-sum val :sha1))
