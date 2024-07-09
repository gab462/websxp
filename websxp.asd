(in-package :cl-user)

(defpackage websxp-asd
  (:use :cl :asdf))

(in-package :websxp-asd)

(defsystem websxp
    :version "0.0.0"
    :license "MIT"
    :pathname "src"
    :serial T
    :depends-on (:cl-punch
                 :arrow-macros
                 :hunchentoot
                 :easy-routes
                 :spinneret
                 :mito
                 :jonathan)
    :components ((:file "db")
                 (:file "pages")
                 (:file "handlers")
                 (:file "core"))
    :build-operation :program-op
    :build-pathname "websxp"
    :entry-point "websxp.core:main")
