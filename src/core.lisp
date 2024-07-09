(in-package :cl-user)

(defpackage websxp.core
  (:use :cl)
  (:import-from :easy-routes :defroute)
  (:import-from :arrow-macros :->>)
  (:local-nicknames (:db :websxp.db)
                    (:pages :websxp.pages)
                    (:handle :websxp.handlers))
  (:export :main))

(in-package :websxp.core)

(defroute contacts ("/" :method :get) ()
    (->> (db:get-all-contacts)
         pages:contacts-table
         (pages:render-page "Contacts")))

(defroute delete-contact ("/contact/:id" :method :delete) (&path (id 'integer))
    (->> (handle:delete-contact id) pages:render-element))

(defun main ()
  (->> (make-instance 'easy-routes:routes-acceptor :port 4444)
       hunchentoot:start))
