(in-package :cl-user)

(defpackage websxp.handlers
  (:use :cl)
  (:local-nicknames (:db :websxp.db))
  (:export :username))

(in-package :websxp.handlers)

(defun username (name)
  (jonathan:to-json
   `(:status 200
     :body (:id ,(db:get-id-from-name name)))))
