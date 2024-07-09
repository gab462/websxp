(in-package :cl-user)

(defpackage websxp.handlers
  (:use :cl)
  (:local-nicknames (:db :websxp.db)
                    (:pages :websxp.pages))
  (:export :delete-contact))

(in-package :websxp.handlers)

(defun delete-contact (id)
  (pages:render-element (pages:contacts-table (db:delete-contact id))))
