(in-package :cl-user)

(asdf:defsystem websxp
    :version "0.0.0"
    :license "MIT"
    :serial T
    :components ((:file "db")
                 (:file "handlers")
                 (:file "pages")
                 (:file "core"))
    :depends-on (:hunchentoot
                 :easy-routes
                 :spinneret
                 :lass
                 :parenscript
                 :sqlite
                 :sxql
                 :jonathan))
