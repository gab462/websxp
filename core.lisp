(in-package :cl-user)

(defpackage websxp.core
  (:use :cl)
  (:import-from :easy-routes :defroute)
  (:local-nicknames (:db :websxp.db)
                    (:page :websxp.pages)
                    (:handle :websxp.handlers))
  (:export :start-server
           :stop-server))

(in-package :websxp.core)

(defparameter *server*
  (make-instance 'easy-routes:routes-acceptor :port 4444))

(defun start-server ()
  (db:connect)
  (hunchentoot:start *server*))

(defun stop-server ()
  (db:disconnect)
  (hunchentoot:stop *server*))

(defroute hello  ("/" :method :get) (name)
  (page:hello name))

(defroute username-id  ("/username/:name" :method :get) ()
  (handle:username name))
