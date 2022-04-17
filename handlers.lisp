(in-package :cl-user)

(defpackage websxp.handlers
  (:use :cl)
  (:local-nicknames (:db :websxp.db))
  (:export :username-id))

(in-package :websxp.handlers)

(defun username-id (name)
  (jonathan:to-json
   `(:status 200
     :body (:id ,(db:get-id-from-name name)))))
