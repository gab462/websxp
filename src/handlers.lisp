(in-package :cl-user)

(defpackage websxp.handlers
  (:use :cl)
  (:import-from :arrow-macros :->)
  (:local-nicknames (:db :websxp.db)
                    (:pages :websxp.pages))
  (:export :delete-contact))

(in-package :websxp.handlers)

(defun delete-contact (id)
  (-> (db:delete-contact id) pages:contacts-table))
