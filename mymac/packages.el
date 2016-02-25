(defvar mymac-packages
  '(redo
    ;mac-key-mode
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defun mymac-init-redo-mode()
  (use-package redo))

