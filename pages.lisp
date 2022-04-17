(in-package :cl-user)

(defpackage websxp.pages
  (:use :cl)
  (:import-from :parenscript :ps :ps*)
  (:local-nicknames (:db :websxp.db))
  (:export :hello))

(in-package :websxp.pages)

(defun hello (name)
  (spinneret:with-html-string
      (:html
       (:head
        (:style (lass:compile-and-write
                 '(body
                   :background-color "yellow"))))
       (:body
        (:div :class "wrapper"
              (:h1 "Homepage")
              (if name
                  (:p (format nil "Hi, ~A!" name))
                  (:p "No name provided"))
              (:br)
              (:a :href "#"
                  :onclick (if name
                               (ps* `(alert ,(db:get-id-from-name name)))
                               (ps (alert "No name provided")))
                  "Get id from name"))))))
