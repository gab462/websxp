(in-package :cl-user)

(defpackage websxp.pages
  (:use :cl)
  (:import-from :arrow-macros :->)
  (:export :contacts-table
           :render-page
           :render-element))

(in-package :websxp.pages)

(cl-punch:enable-punch-syntax)

(defun make-page (title body)
  `(:html
    (:head
     (:title ,title)
     (:link :href "https://cdn.jsdelivr.net/npm/@picocss/pico@2.0.6/css/pico.classless.min.css"
            :rel "stylesheet"))
    (:body
     (:script :src "https://unpkg.com/htmx.org@2.0.0"
              :type "text/javascript")
     (:header (:h1 ,title))
     ,body)))

(defun render-page (title page)
  (-> (make-page title page)
      spinneret:interpret-html-tree
      spinneret:with-html-string))

(defun render-element (element)
  (-> element
      spinneret:interpret-html-tree
      spinneret:with-html-string))

(defun contacts-table (contacts)
  `(:main
    (:section
     :id "table"
     (:form
      (:table
       (:thead
        ,@(mapcar ^(list :th _) '("Name" "Email" "Status"))
        (:th))
       (:tbody :hx-confirm "Are you sure?" :hx-target "closest tr" :hx-swap "outerHTML"
               ,@(mapcar ^(destructuring-bind (&key id name email status) _
                            `(:tr
                              ,@(mapcar (lambda (field) (list :td field)) (list name email status))
                              (:td (:button :hx-delete ,(format nil "/contact/~A" id) "Delete"))))
                         contacts)))))))
