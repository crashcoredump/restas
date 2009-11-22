;;;; expand-text.lisp
;;;;
;;;; This file is part of the RESTAS library, released under Lisp-LGPL.
;;;; See file COPYING for details.
;;;;
;;;; Author: Moskvitin Andrey <archimag@gmail.com>


(in-package :restas)

(defun expand-text/impl (template bindings out &optional (start 0))
  (let* ((var-start (search "${"
                            template
                            :start2 start))
         (var-end (and var-start 
                       (search "}"
                               template
                               :start2 var-start))))
    (if var-end
        (progn (write-string template
                             out
                             :start start
                             :end var-start)
               (let ((var-value (cdr (assoc (find-symbol (string-upcase (subseq template (+ 2 var-start) var-end))
                                                         :keyword)
                                            bindings))))
                 (if var-value
                     (format out "~A" var-value)
                     (write-string template
                                   out
                                   :start var-start
                                   :end (1+ var-end))))
               (expand-text/impl template
                                 bindings
                                 out
                                 (1+ var-end)))
        (write-string template out :start start))))
    
(defun expand-text (template bindings)
  (with-output-to-string (out)
    (expand-text/impl template bindings out)))

(defun expand-file (path bindings)
  "Loads a template file and substitutes the value of the bindings"
  (restas::expand-text (alexandria:read-file-into-string path)
                       bindings))