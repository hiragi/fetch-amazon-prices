#|
  This file is a part of fetch-amazon-prices project.
|#

(in-package :cl-user)
(defpackage fetch-amazon-prices-asd
  (:use :cl :asdf))
(in-package :fetch-amazon-prices-asd)

(defsystem fetch-amazon-prices
  :version "0.1"
  :author ""
  :license ""
  :depends-on (:drakma :cl-ppcre :cxml-stp :cl-annot :cl-syntax :closure-html)
  :components ((:module "src"
                :components
                ((:file "fetch-amazon-prices"))))
  :description "")
