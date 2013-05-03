#|
  This file is a part of fetch-amazon-prices project.
|#

(in-package :cl-user)
(defpackage fetch-amazon-prices-test-asd
  (:use :cl :asdf))
(in-package :fetch-amazon-prices-test-asd)

(defsystem fetch-amazon-prices-test
  :author ""
  :license ""
  :depends-on (:fetch-amazon-prices
               :cl-test-more)
  :components ((:module "t"
                :components
                ((:file "fetch-amazon-prices"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
