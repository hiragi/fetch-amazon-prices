#|
  This file is a part of fetch-amazon-prices project.
|#

(in-package :cl-user)
(defpackage fetch-amazon-prices
  (:use :cl)
  (:export :fetch-all))
(in-package :fetch-amazon-prices)

(defun _fetch-results (url)
  (let* ((str (drakma:http-request url))
         (document (chtml:parse str (cxml-stp:make-builder)))
         (acc '()))
    (stp:do-recursively (result document)
      (when (and (typep result 'stp:element)
                 (or
                  (equal (stp:attribute-value result "class") "")
                  (equal (stp:attribute-value result "class") "mtc nolb norb nobb notb"))
                 (stp:string-value result))
        (setf acc (cons (stp:string-value result) acc))))
    (reverse acc)))

(defun fetch-prices (url)
  (let ((prices '()))
    (loop for result in (_fetch-results url)
       do (setf result (cl-ppcre:regex-replace-all #\newline result ""))
       when (cl-ppcre:scan "¥" result)
         collect (setf prices (cons result prices))
       when (cl-ppcre:scan "Not in stock" result)
         collect (setf prices (cons result prices)))
    (reverse prices)))

(defun fetch-dates (url)
  (let ((dates '()))
    (loop for result in (_fetch-results url)
       do (setf result (cl-ppcre:regex-replace-all #\newline result ""))
       when (cl-ppcre:scan "20" result)
         collect (setf dates (cons result dates)))

    (reverse dates)))

;@export
(defun fetch-all (url)
  (let* ((dates (fetch-dates url))
         (prices (fetch-prices url))
         (len-dates (length dates))
         (len-prices (length prices))
         (result dates))
    (when (<= len-dates len-prices)
      (dotimes (i (- len-prices len-dates))
        (setf result (cons nil result))))
    (loop for price in prices
       for date in result
       collect (cons
                (cl-ppcre:regex-replace-all " " date "")
                (cl-ppcre:regex-replace-all " " price "")))))
