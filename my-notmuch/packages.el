;;; packages.el --- notmuch Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq my-notmuch-packages
      '(
        ;; package names go here
        notmuch
;        notmuch-address
        ))

;; List of packages to exclude.
(setq my-notmuch-excluded-packages '())

;; For each package, define a function notmuch/init-<package-name>
;;
(defun my-notmuch/init-notmuch ()
  "Initialize my package"
  (use-package notmuch
    :defer t
    :commands notmuch
    :init
    (progn
      (spacemacs/set-leader-keys "om" 'notmuch)
      (load-library "org-notmuch")
      ;; Fix helm
     ;; See id:m2vbonxkum.fsf@guru.guru-group.fi
     (setq notmuch-address-selection-function
           (lambda (prompt collection initial-input)
             (completing-read prompt (cons initial-input collection) nil t nil 'notmuch-address-history)))

     ;;(spacemacs/declare-prefix-for-mode 'notmuch-show-mode "n" "notmuch")
     ;;(spacemacs/declare-prefix-for-mode 'notmuch-show-mode "n." "MIME parts")

     (defun lehoff/notmuch-trash (&optional beg end)
       "trash by removing inbox and adding trash"
       (interactive (notmuch-search-interactive-region))
       (notmuch-search-tag (list "-inbox" "+trash") beg end)
       (when (eq beg end)
         (notmuch-search-next-thread)))

     (defun lehoff/notmuch-trash-show ()
       "trash shown msg by removing inbox and adding trash"
       (interactive)
       (notmuch-show-add-tag (list "-inbox" "+trash"))
       (unless (notmuch-show-next-open-message)
         (notmuch-show-next-thread t)))

     (defun lehoff/compose-mail-other-frame ()
       "create a new frame for the mail composition"
       (compose-mail-other-frame))

     (evilified-state-evilify notmuch-hello-mode notmuch-hello-mode-map)
     (evilified-state-evilify notmuch-show-mode notmuch-show-stash-map)
     (evilified-state-evilify notmuch-show-mode notmuch-show-part-map)
     (evilified-state-evilify notmuch-show-mode notmuch-show-mode-map
              (kbd "N") 'notmuch-show-next-message
              (kbd "n") 'notmuch-show-next-open-message
              (kbd "T") 'lehoff/notmuch-trash-show)

     (evilified-state-evilify notmuch-tree-mode notmuch-tree-mode-map)
     (evilified-state-evilify notmuch-search-mode notmuch-search-mode-map)
     (evilified-state-evilify notmuch-search-mode notmuch-search-mode-map
       (kbd "J") 'notmuch-jump-search
       (kbd "L") 'notmuch-search-filter
       (kbd "T") 'lehoff/notmuch-trash
       (kbd "M") 'compose-mail-other-frame)
     ;; (evilify notmuch-hello-mode notmuch-hello-mode-map
     ;;          "J" 'notmuch-jump-search)
     ;; (evilify notmuch-search-mode notmuch-search-mode-map
     ;;          "J" 'notmuch-jump-search
     ;;          "gg" 'notmuch-search-first-thread
     ;;          "G" 'notmuch-search-last-thread)
     ;; (evilify notmuch-show-mode notmuch-show-mode-map
     ;;          "J" 'notmuch-jump-search)
     (defun lehoff/notmuch-remove-inbox-tag ()
       "archive by removing INBOX tag"
       (interactive (notmuch-search-interactive-region))
       (notmuch-search-tag (list "+archive" "-inbox") beg end))

     (evil-define-key 'normal notmuch-search-mode-map
       "F" 'lehoff/notmuch-remove-inbox-tag)

     (evil-define-key 'visual notmuch-search-mode-map
              "*" 'notmuch-search-tag-all
              "a" 'notmuch-search-archive-thread
              "-" 'notmuch-search-remove-tag
              "+" 'notmuch-search-add-tag
              "F" '(lambda (&optional beg end)
                    "archive by removing inbox tag"
                    (interactive (notmuch-search-interactive-region))
                    (notmuch-search-tag (list "+archive" "-inbox") beg end)))


    (setq notmuch-address-command "~/bin/nottoomuch-addresses.sh")

    (setq message-send-mail-function 'message-send-mail-with-sendmail)
    (setq sendmail-program "~/bin/msmtp-enqueue.sh")
    (setq message-sendmail-extra-arguments '("-a" "Basho"))
    (setq mail-host-address "@basho.com")
    (setq user-full-name "Torben Hoffmann")
    (setq user-mail-address "thoffmann@basho.com")
    (setq message-sendmail-f-is-evil 't)))


  ;; from https://github.com/fgeller/emacs.d/blob/master/email.org
  (add-hook 'notmuch-show-hook 'notmuch-show-prefer-html-over-text)
  (defun notmuch-show-prefer-html-over-text ()
    (interactive)
    (let* ((text-button (save-excursion
                          (goto-char (point-min))
                          (search-forward "[ text/plain ]" (point-max) t)))
           (html-button (save-excursion
                          (goto-char (point-min))
                          (search-forward "[ text/html (hidden) ]" (point-max) t))))
      (when html-button
        (save-excursion
          (goto-char (- html-button 1))
          (notmuch-show-toggle-part-invisibility)))
      (when text-button
        (save-excursion
          (goto-char (- text-button 1))
          (notmuch-show-toggle-part-invisibility)))))
  )


;; For each package, define a function notmuch/init-<package-name>
;;
(defun my-notmuch/init-notmuch-address ()
  "Initialize my package"
  (use-package notmuch-address
    :defer t
    :init
    (progn
      (setq notmuch-address-command "~/bin/notmuch-addresses.py"))
    )
  )
