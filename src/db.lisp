(in-package :cl-user)

(defpackage websxp.db
  (:use :cl)
  (:import-from :arrow-macros :->>)
  (:export :create-contact
           :delete-contact
           :get-all-contacts))

(in-package :websxp.db)

(mito:connect-toplevel :sqlite3 :database-name #P"contacts.db")

(mito:deftable contact ()
  ((name :col-type :text)
   (email :col-type :text)
   (status :col-type :text)))

(mito:ensure-table-exists 'contact)

(defgeneric as-plist (obj)
  (:documentation "Convert mito object to plist"))

;; FIXME: slow?
(defmethod as-plist ((obj contact))
  `(:id ,(mito:object-id obj)
    :name ,(contact-name obj)
    :email ,(contact-email obj)
    :status ,(contact-status obj)))

(defun create-contact (name email status)
  (->> (mito:create-dao 'contact :name name :email email :status status)
       as-plist))

(defun delete-contact (id)
  (mito:delete-by-values 'contact :id id)
  (get-all-contacts))

(defun get-all-contacts ()
  (->> (mito:select-dao 'contact)
       (mapcar 'as-plist)))
