(in-package :cl-user)

(defpackage websxp.core
  (:use :cl)
  (:import-from :easy-routes :defroute)
  (:local-nicknames (:db :websxp.db)
                    (:pages :websxp.pages)
                    (:handle :websxp.handlers))
  (:export :main))

(in-package :websxp.core)

(defroute contacts ("/" :method :get) ()
    (pages:render-page "Contacts" (pages:contacts-table (db:get-all-contacts))))

(defroute delete-contact ("/contact/:id" :method :delete) (&path (id 'integer))
    (handle:delete-contact id))

(defun main ()
  (hunchentoot:start (make-instance 'easy-routes:routes-acceptor :port 5000)))
