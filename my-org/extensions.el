

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq org-default-notes-file "~/org/notes.org")
(setq org-capture-templates
      '(("t" "Task" entry (file+headline "~/org/notes.org" "Tasks")
         "* TODO %?\n  %i\n  %a")))

(setq org-clock-persist 'history)
;; (org-clock-persistence-insinuate)
(setq org-log-done 'note)

(setq org-startup-indented 'indented)

;; (add-hook 'org-mode-hook 'my-org-mode-autosave-settings)
;; (defun my-org-mode-autosave-settings () "Customisation of org-mode autosave"
;;   ;; (auto-save-mode 1)   ; this is unecessary as it is on by default
;;   (set (make-local-variable 'auto-save-visited-file-name) t)
;;   (setq auto-save-interval 20))

(global-set-key (kbd "s-<f9>") 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;(add-hook 'org-mode-hook (lambda ()
;;  (define-key org-mode-map (kbd "C-c C-g") 'org-mac-grab-link)))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/refile.org" "Tasks")
             "* TODO %?\n  %i\n  %a")))

; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))

(setq org-agenda-files (quote ("~/org")))
(setq org-clock-in-resume t)
(setq org-clock-persist t)
(setq org-clock-report-include-clocking-task t)
(setq org-log-done (quote note))
(setq org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-info org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m)))
(setq org-support-shift-select t)

(setq org-time-clocksum-format
'(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))

;;; hack to get rid of sub-tree but keep node.
(defun lehoff/org-archive-subtree-keep-node ()
  (interactive)
  (setq node-text (thing-at-point 'line))
  (org-archive-subtree)
  (insert-string node-text))

;;;(global-set-key (kbd "<f8>") 'lehoff/org-archive-subtree-keep-node)
;;; (global-set-key (kbd "C-<f8>") 'org-archive-subtree)
(global-set-key (kbd "<f9>") 'org-agenda)
(global-set-key (kbd "C-<f9>") 'org-search-view)
(global-set-key (kbd "<f7>") 'org-save-all-org-buffers)
(global-set-key (kbd "<f6>") 'org-clock-in)
(global-set-key (kbd "C-<f6>") 'org-clock-out)


;;; MobileOrg set-up
;; Set to the location of your Org files on your local system
(setq org-directory "~/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/refile.org")
;; Set to <your Dropbox root directory>/MobileOrg.
                                        ;(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
(setq org-mobile-directory "/Volumes/LeHoff/org")
