(in-package :cl-user)

(defpackage websxp.db
  (:use :cl)
  (:import-from :sxql :select :from :where)
  (:export :connect
           :disconnect
           :get-id-from-name))

(in-package :websxp.db)

(defparameter *db* nil)

(defun connect ()
  (setf *db* (sqlite:connect "sqlite.db")))

(defun disconnect ()
  (setf *db* (sqlite:disconnect *db*)))

;; Disable library SQL Injection protection.
;; sxql:yield returns string with placeholder (?),
;; but not sure how to fill with the actual data.
;; TODO: ensure security on application level.
(setf sxql:*use-placeholder* nil)

(defun db-query-one (query)
  (sqlite:execute-single *db* (sxql:yield query)))

(defun get-id-from-name (name)
  (db-query-one (select :rowid
                  (from :users)
                  (where (:= :name name)))))
