(setq custom-theme-directory "~/.emacs.d/themes/")

;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes '(modus-vivendi my-wombat))
 '(custom-safe-themes
   '("0279bed8db57df6f093b2f143d45934320532b99ec212a4a9c59d0484934763c"
     "90903f9847cdccac16cc658dd06ae8906bccdf73327952d17b65633d9508fa71"
     "e5c58b45a93d2f9f87e727d8d2b17ce7ba792d12cee6ecef6e27b5b2ea25c60e"
     "fc809f7a044fefc09dbacf8170083a7957c21d53e1a0cc3146fcfe5d65747f9c"
     default))
 '(menu-bar-mode nil)
 '(org-agenda-files nil t)
 '(package-selected-packages
   '(ac-slime cl-libify company-anaconda elpy elpygen evil paredit
              rainbow-delimiters slime-company))
 '(tool-bar-mode nil))


;;;EMACS CUSTOM OPTIONS
(setq fill-column 70)
(add-hook 'dired-mode-hook 'dired-omit-mode); hide backup files
(setq blink-cursor-blinks 0); never stop blinking 
(column-number-mode t); show column number on mode line
(icomplete-mode 1); show completion on the minibuffer
(setq completions-format 'one-column); or 'horizontal, or 'one-column
(setq completion-auto-select 'second-tab); Focus on completions buffer 
(setq cursor-in-non-selected-windows nil) ; show cursor only in the active window
(setq-default indent-tabs-mode nil); Use spaces, not tabs, for indentation.
(setq doc-view-scale-internally t)
(setq doc-view-resolution 300)
(scroll-bar-mode -1); hide scroll bar
(setq scroll-margin 4)
(setq scroll-step 1)
(setq inhibit-startup-screen t)
(setq dired-kill-when-opening-new-dired-buffer 1)
(setq help-window-select t)  ; Switch focus to help buffers automatically
(electric-pair-mode t) ; Match parenthesis
(set-face-attribute 'default nil :font "Noto Sans Mono" :height 120)


(add-hook 'lisp-mode-hook 'display-line-numbers-mode)
(add-hook 'emacs-lisp-mode-hook 'display-line-numbers-mode)
(add-hook 'c-mode-hook 'display-line-numbers-mode)
(add-hook 'python-mode-hook 'display-line-numbers-mode)
(add-hook 'sh-mode-hook 'display-line-numbers-mode)


;;;KEY BINDINGS
(keymap-global-set "C-c b" 'ibuffer)
(keymap-global-set
 ;Load init.el
 "C-c l i"
 (lambda ()
   (interactive)
   (load-file (expand-file-name "~/.emacs.d/init.el"))))


;;GIT
(defun my-git-push-current-file ()
   (interactive)
   (async-shell-command
    (format "git add %s && git commit -m \"emacs\" && git push"
            (buffer-name))))
(keymap-global-set "C-c g p f" #'my-git-push-current-file)

(defun my-git-push-folder ()
   (interactive)
   (async-shell-command
    (format "git add . && git commit -m \"emacs\" && git push")))

(defun my-git-push-init-and-org ()
  (interactive)
  (async-shell-command
   (format "cd %s && git add init.el && git commit -m \"auto\" && git push"
           (expand-file-name "~/.emacs.d/")))
  (shell-command
   (format "cd %s && git add . && git commit -m \"auto\" && git push"
           (expand-file-name "~/org/"))))
(keymap-global-set "C-c g p a" #'my-git-push-init-and-org)


;;;PACKAGE MANAGER
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


;;;ORG

;;breaks lines automatically
(add-hook 'org-mode-hook #'auto-fill-mode)

;;automaticaly change to overview when entering some files
(add-hook 'find-file-hook
          (lambda ()
            (let ((file-names (list
                               "projects.org"
                               "inbox.org")))
              (when (member
                     (buffer-last-name)
                     file-names)
                (org-cycle-global)))))


(setq org-todo-keywords
      '((sequence "TODO" "PROG" "DONE")))

(setq org-todo-keyword-faces
      '(("PROG" . "yellow")))


(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-todo-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook #'org-summary-todo)


(setq org-capture-templates
      '(("g" "Generic note" plain
         (file "~/org/notes/generic.org")
         "** %?\n%U\n%a\n-------------------------------------------------------------"
         :jump-to-captured t
         :empty-lines-before 1
         :empty-lines-after 1)
        
        ("w" "Work note" plain
         (file+headline "~/org/notes/work.org" "Current")
         "** %?\n%U\n-------------------------------------------------------------"
         :jump-to-captured t
         :empty-lines-before 1
         :empty-lines-after 1)
        
        ;; ("s" "Study note" plain
        ;;  (file+headline "~/org/notes/generic.org" "study")
        ;;  "pg: x\n _%x_ %?"
        ;;  :jump-to-captured t
        ;;  :empty-lines-before 1
        ;;  :empty-lines-after 1)
        
        ("t" "TODO" plain
         (file+headline "~/org/gtd/inbox.org" "New")
         "** TODO %?")))

(define-key global-map (kbd "C-c c" )'org-capture)

;;dired
(defun my-orgd ()
  (interactive)
  (dired "~/org"))

(define-key global-map (kbd "<f9>") 'my-orgd)

(defun my-notesd ()
  (interactive)
  (dired "~/notes/"))

;(setq org-refile-use-outline-path 'file)

(setq org-refile-targets
       '(("~/org/gtd/projects.org" :maxlevel . 1)
         ("~/org/gtd/someday.org" :maxlevel . 1)
         (nil :maxlevel . 1)))
;;refile
;;this is better for maintence
;(setq org-agenda-files (list "~/org/gtd/projects.org"
;                             "~/org/gtd/someday.org"))

;(setq org-refile-targets '((org-agenda-files :maxlevel . 1)))

;;this has no advantages
;; (setq org-agenda-files (list "~/org/notes/studies/"))

;; (setq org-refile-targets '(("~/org/gtd/projects.org" :maxlevel . 1)
;;                            ("~/org/gtd/someday.org" :maxlevel . 1)
;;                            (nil :maxlevel . 1)
;;                            (org-agenda-files :maxlevel . 1)))

;;this is better for more explicit locations
;; (setq org-refile-targets
;;       (append
;;        '(("~/org/gtd/projects.org" :maxlevel . 1)
;;          ("~/org/gtd/someday.org" :maxlevel . 1)
;;          (nil :maxlevel . 1))
;;        (mapcar (lambda (file)
;;                  (cons (concat "~/org/notes/studies/" file) '(:maxlevel . 1)))
;;                (directory-files "~/org/notes/studies/" nil "\\.org$"))))


;;;SLIME
(setq inferior-lisp-program "sbcl")
(require 'slime-autoloads)
(slime-setup '(slime-fancy slime-company))

(add-hook 'lisp-mode-hook
	  (lambda () (keymap-local-set "C-c e b" #'slime-eval-buffer)))

(defun open-slime-and-go-back ()
  "Start slime and return focus to original window."
  (interactive)
  (let ((original-window (selected-window)))
    (slime)
    (select-window original-window)))

(add-hook 'lisp-mode-hook
	  (lambda ()
            (keymap-local-set "C-c s s" #'open-slime-and-go-back)))

;;todo clear repl
;;go to buffer named *slime-repl sbcl*
;; slime-repl-clear-buffer
;; go back to original windows


;;;COMPANY CONFIG
(add-hook 'after-init-hook 'global-company-mode) ;company starts when emacs boots

(keymap-global-set "C-<tab>" 'company-complete)
(with-eval-after-load 'company
  (define-key company-active-map
              (kbd "C-<tab>")
              #'company-select-next)
  (define-key company-active-map
              (kbd "<backtab>")
              (lambda ()
                (interactive)
                (company-select-previous))))

(setq company-tooltip-align-annotations t
      company-tooltip-offset-display 'lines
      company-minimum-prefix-length 0
      company-idle-delay nil
      company-lighter-base t
      company-global-modes '(not erc-mode message-mode eshell-mode)
      company-frontends '(company-pseudo-tooltip-frontend
			  company-preview-frontend
			  company-echo-metadata-frontend))

(eval-after-load "company"
  '(add-to-list 'company-backends 'company-anaconda))
(add-hook 'python-mode-hook 'anaconda-mode)


;;;EVIL MODE
;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
;; To avoid bugs, it seems that (require 'evil) and (evil-mode 1)
;; must come after the evil-disable-insert-state-bindings
(setq evil-disable-insert-state-bindings t) ; insert state becomes emacs state
(require 'evil) 
(evil-mode 1)

;; evil is not optimal for some modes
(setq evil-default-state 'insert)
(evil-set-initial-state 'electric-buffer-menu-mode 'emacs)
(evil-set-initial-state 'Info-mode 'emacs)
(evil-set-initial-state 'help-mode 'emacs)


;; TODO: create a command that plays the M-! with the arguments
;; git add (current-file) && git commit -m "up" && git xpushx
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
