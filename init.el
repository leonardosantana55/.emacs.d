(setq custom-theme-directory "~/.emacs.d/themes/")

;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(ac-slime cl-libify company-quickhelp evil slime-company vterm))
 '(tool-bar-mode nil))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;EMACS CUSTOM OPTIONS
(savehist-mode 1)
(push 'kill-ring savehist-additional-variables)
(which-key-mode)
(scroll-bar-mode -1); hide scroll bar
(electric-pair-mode t) ; Match parenthesis
(column-number-mode t); show column number on mode line
(setq-default cursor-type '(bar . 2))

(define-key global-map (kbd "<f9>") 'bookmark-bmenu-list)
(global-unset-key (kbd "C-v")); stop emacs from moving when i make a mistake

(setq ring-bell-function 'ignore)
(setq tab-width 4)
(setq-default indent-tabs-mode nil); Use spaces, not tabs, for indentation.
(setq fill-column 80)
(setq blink-cursor-blinks 0); never stop blinking 
(setq completions-format 'one-column); or 'horizontal, or 'one-column
(setq cursor-in-non-selected-windows nil) ; show cursor only in the active window
(setq doc-view-scale-internally t)
(setq doc-view-resolution 300)
(setq scroll-margin 4)
(setq scroll-step 1)
(setq inhibit-startup-screen t)
(setq help-window-select t)  ; Switch focus to help buffers automatically

(set-face-attribute 'default nil :font "Noto Sans Mono" :height 120)
(set-face-attribute 'italic nil :family "Noto Mono" :slant 'italic :height 120)

(add-hook 'lisp-mode-hook 'display-line-numbers-mode)
(add-hook 'emacs-lisp-mode-hook 'display-line-numbers-mode)
(add-hook 'c-mode-hook 'display-line-numbers-mode)
(add-hook 'python-mode-hook 'display-line-numbers-mode)
(add-hook 'sh-mode-hook 'display-line-numbers-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;WINDOW MANAGEMENT

(add-to-list 'display-buffer-alist
             '("\\*vterm*"
               ;;(display-buffer-full-frame)
               (display-buffer-at-bottom)
               (window-height . 12)
               ))


;;or should i put this on the vterm section?
;;TODO add a shortcut to open or to close depending on state.
;;i want to open and close vterm with the same keystroke.
;; https://www.reddit.com/r/emacs/comments/179t67l/window_management_share_your_displaybufferalist/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;MODUS THEME

(defun hex-color-factor (hex-color-string factor)
  "Diminish a HEX color string by a given factor (0.0 to 1.0).
A factor of 1.0 means no change, 0.5 makes it 50% darker.
The input string can be \"#RRGGBB\" or \"RRGGBB\"."
  (let* ((hex (if (string-match "#" hex-color-string)
                  (substring hex-color-string 1)
                hex-color-string))
         (r-hex (substring hex 0 2))
         (g-hex (substring hex 2 4))
         (b-hex (substring hex 4 6))
         (r-int (string-to-number r-hex 16))
         (g-int (string-to-number g-hex 16))
         (b-int (string-to-number b-hex 16))
         (new-r (max 0 (min 255 (floor (* r-int factor)))))
         (new-g (max 0 (min 255 (floor (* g-int factor)))))
         (new-b (max 0 (min 255 (floor (* b-int factor)))))
         (new-r-hex (format "%02x" new-r))
         (new-g-hex (format "%02x" new-g))
         (new-b-hex (format "%02x" new-b)))
    (format "#%s%s%s" new-r-hex new-g-hex new-b-hex)))


(require-theme 'modus-themes)
(setq modus-themes-bold-constructs t)
(setq modus-themes-to-toggle (list 'modus-vivendi 'modus-operandi-tinted))
;;(setq modus-vivendi-palette-overrides modus-themes-preset-overrides-faint)

(setq modus-themes-common-palette-overrides
    '((builtin "#5f6879")
        (comment fg-dim)
        (constant fg-main)
        (docstring green-intense)
        (docmarkup fg-main)
        (fnname red-cooler)
        (keyword yellow-warmer)
        (preprocessor blue-faint)
        (string green-intense)
        (type fg-main)
        (variable fg-main)
        (rx-construct fg-main)
        (rx-backslash fg-main)))

(let ((bg "#0e1217"))
;(let ((bg "#14181f"))
  (setq modus-vivendi-palette-overrides
        `(
          (bg-main ,(hex-color-factor bg 1))
          (bg-active ,(hex-color-factor bg 2.5))
          (bg-inactive ,(hex-color-factor bg 2.1))
          (fg-main "#fcfadc")
          (fg-dim ,(hex-color-factor bg 7.5))
          ;;(bg-completion bg-inactive)
          ;;(bg-hl-line bg-dim)
          (bg-paren-match red)
          (fg-paren-match bg-main)
          (bg-region blue-intense)
          (fg-region fg-main)
          (bg-mode-line-active bg-active)
          (fg-mode-line-active fg-active)
          (fg-mode-line-inactive ,(hex-color-factor bg 3.5))
          (border-mode-line-active fg-dim)
          (bg-mode-line-inactive bg-main)
          (border-mode-line-inactive fg-dim)
          (bg-tab-bar bg-inactive)
          (bg-tab-current bg-main)
          (bg-tab-other bg-active)
          (fringe bg-main)
          ;; (builtin maroon)
          ;; (comment fg-dim)
          ;; (constant blue-faint)
          ;; (docstring fg-alt)
          ;; (docmarkup magenta-faint)
          ;; (fnname pink)
          ;; (keyword indigo)
          ;; (preprocessor rust)
          ;; (string slate)
          ;; (type cyan-faint)
          ;; (variable cyan-faint)
          ;; (rx-construct gold)
          ;; (rx-backslash olive)
          ;; (underline-err red-faint)
          ;; (underline-warning yellow-faint)
          ;; (underline-note cyan-faint)
          ;; (bg-button-active bg-main)
          ;; (fg-button-active fg-main)
          ;; (bg-button-inactive bg-inactive)
          ;; (fg-button-inactive "gray50")
          ;; (date-common cyan-faint)
          ;; (date-deadline red-faint)
          ;; (date-event fg-alt)
          ;; (date-holiday magenta)
          ;; (date-now fg-main)
          ;; (date-scheduled yellow-faint)
          ;; (date-weekday fg-dim)
          ;; (date-weekend fg-dim)
          ;; (name maroon)
          ;; (identifier fg-dim)
          (fg-line-number-active fg-main)
          ;; (fg-line-number-inactive ,(hex-color-factor bg 3.5))
          (fg-line-number-inactive "#3f4859")
          (bg-line-number-active unspecified)
          (bg-line-number-inactive bg-main)
          ;; (fg-link blue-faint)
          ;; (bg-link unspecified)
          ;; (underline-link bg-active)
          ;; (fg-link-symbolic cyan-faint)
          ;; (bg-link-symbolic unspecified)
          ;; (underline-link-symbolic bg-active)
          ;; (fg-link-visited magenta-faint)
          ;; (bg-link-visited unspecified)
          ;; (underline-link-visited bg-active)
          ;; (mail-cite-0 cyan-faint)
          ;; (mail-cite-1 yellow-faint)
          ;; (mail-cite-2 green-faint)
          ;; (mail-cite-3 red-faint)
          ;; (mail-part olive)
          ;; (mail-recipient indigo)
          ;; (mail-subject maroon)
          ;; (mail-other slate)
          ;; (fg-prompt cyan-faint)
          ;; (fg-prose-code olive)
          ;; (fg-prose-macro indigo)
          ;; (fg-prose-verbatim maroon)
          ;; (prose-done green-faint)
          ;; (prose-tag rust)
          ;; (prose-todo red-faint)
          ;; (rainbow-0 fg-main)
          ;; (rainbow-1 magenta)
          ;; (rainbow-2 cyan)
          ;; (rainbow-3 red-faint)
          ;; (rainbow-4 yellow-faint)
          ;; (rainbow-5 magenta-cooler)
          ;; (rainbow-6 green)
          ;; (rainbow-7 blue-warmer)
          ;; (rainbow-8 magenta-faint)
          )))

(load-theme 'modus-vivendi)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;KEY BINDINGS
(keymap-global-set "C-c b" 'ibuffer)
(keymap-global-set
 ;Load init.el
 "C-c l i"
 (lambda ()
   (interactive)
   (load-file (expand-file-name "~/.emacs.d/init.el"))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
  (async-shell-command
   (format "cd %s && git add . && git commit -m \"auto\" && git push"
           (expand-file-name "~/org/"))))
(keymap-global-set "C-c g p a" #'my-git-push-init-and-org)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;PACKAGE MANAGER
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;ORG
(setq org-hide-emphasis-markers t)
(setq org-reverse-note-order t) ;; refile adds items to the top
(setq org-agenda-files '("~/org"))
(setq org-bookmark-names-plist nil) ;;stops org from auto creating bookmarks

(add-hook 'org-mode-hook #'auto-fill-mode) ;;breaks lines automatically

;;automaticaly change to overview when entering some files
(add-hook 'find-file-hook
          (lambda ()
            (let ((file-names (list
                               "projects.org"
                               "tasks.org")))
              (when (member
                     (buffer-last-name)
                     file-names)
                (org-cycle-global)))))

(setq org-todo-keywords
      '((sequence "TODO" "PROG" "WAIT" "DONE")))

(setq org-todo-keyword-faces
      '(("PROG" . "orange")
        ("WAIT" . "cyan")))

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-todo-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook #'org-summary-todo)

(setq org-capture-templates
      '(("g" "Generic note" plain
         (file+headline "~/org/gtd/inbox.org" "Generic")
         "** %?\n%U\n%a\n-------------------------------------------------------------"
         :jump-to-captured t
         :prepend t
         :empty-lines-before 1
         :empty-lines-after 1)
        
        ("w" "Work note" plain
         (file+headline "~/org/gtd/inbox.org" "Work")
         "** %?\n%U\n-------------------------------------------------------------"
         :jump-to-captured t
         :prepend t
         :empty-lines-before 1
         :empty-lines-after 1)
        
        ("t" "TODO" plain
         (file+headline "~/org/gtd/inbox.org" "Todo")
         "** TODO %?"
         :prepend t
         :empty-lines-before 1
         :empty-lines-after 1)))

(define-key global-map (kbd "C-c c" )'org-capture)

(setq org-refile-targets
       '(("~/org/gtd/projects.org" :maxlevel . 1)
         ("~/org/gtd/tasks.org" :maxlevel . 1)
         ("~/org/gtd/someday.org" :maxlevel . 1)
         ("~/org/notes/generic.org" :maxlevel . 1)
         ("~/org/notes/ideas.org" :maxlevel . 1)
         ("~/org/notes/work.org" :maxlevel . 1)
         (nil :maxlevel . 1)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;DIRED
(setq dired-kill-when-opening-new-dired-buffer 1)

(add-hook 'dired-mode-hook 'dired-omit-mode); hide backup files
(add-hook 'dired-mode-hook 'hl-line-mode); highligths line in dired
(add-hook 'dired-mode-hook 'dired-hide-details-mode); bound to "("

(keymap-global-set
 "C-x C-d"
 (lambda ()
   (interactive)
   (dired ".")))

(setq dired-listing-switches "-vAFla")

(defun goto-and-kill-dired ()
    (interactive)
    (let ((buffer-name (buffer-name)))
      (dired-find-file)
      (kill-buffer buffer-name)))

(add-hook 'dired-mode-hook
          (lambda ()
            (keymap-local-set "RET" #'goto-and-kill-dired)
            (keymap-local-set "C-<return>" #'dired-find-file)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;BOOKMARKS
(define-key global-map (kbd "<f9>") 'bookmark-bmenu-list)
;; C-x r m createas a new bookmark
(defun kill-buffer-bookmark ()
  (interactive)
  (kill-buffer (buffer-name)))

(defun goto-and-kill-bookmark ()
    (interactive)
    (let ((buffer-name (buffer-name)))
      (bookmark-bmenu-this-window)
      (kill-buffer buffer-name)))

(add-hook 'bookmark-bmenu-mode-hook
	  (lambda ()
            (keymap-local-set "RET" #'goto-and-kill-bookmark)
            (keymap-local-set "C-<return>" #'bookmark-bmenu-this-window)
            (keymap-local-set "h" #'evil-backward-char)
            (keymap-local-set "j" #'evil-next-line)
            (keymap-local-set "k" #'evil-previous-line)
            (keymap-local-set "l" #'evil-forward-char)
            (keymap-local-set "<f9>" #'kill-buffer-bookmark)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BUFFERS
(keymap-global-set "C-x C-b" 'switch-to-buffer)
(add-hook 'ibuffer-mode-hook 'ibuffer-do-sort-by-recency); hide backup files

(defun my-kill-buffer-path ()
  (interactive)
  (when (buffer-file-name)
    (kill-new (concat "cd " "\"" (file-name-directory (buffer-file-name)) "\""))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;MIBIBUFFER
(icomplete-vertical-mode t)
(fido-vertical-mode t)
(advice-add 'completion-at-point :after #'minibuffer-hide-completions)
(setq completion-auto-help nil)

(add-hook 'minibuffer-setup-hook
	  (lambda ()
            (keymap-local-set "RET" #'icomplete-force-complete-and-exit)
            (keymap-local-set "TAB" #'icomplete-force-complete)))

(setq completions-sort #'historical)
(setq completions-max-height 9)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;SLIME
(setq inferior-lisp-program "sbcl")
(require 'slime-autoloads)
(slime-setup '(slime-fancy slime-company))
(setq slime-contribs '(slime-fancy slime-asdf))


(defun open-slime-and-go-back ()
  "Start slime and return focus to original window."
  (interactive)
  (let ((original-window (selected-window)))
    (slime)
    (select-window original-window)))

(defun clear-slime-and-go-back ()
  "clear slime and return focus to original window."
  (interactive)
  (let ((original-window (selected-window)))
    (other-window 1)
    (slime-repl-clear-buffer)
    (select-window original-window)))

(add-hook 'lisp-mode-hook
	  (lambda ()
            (keymap-local-set "<f7>" #'clear-slime-and-go-back)
            (keymap-local-set "<f6>" #'slime-eval-buffer)
            (keymap-local-set "<f5>" #'slime-eval-defun)
            (keymap-local-set "C-c s s" #'open-slime-and-go-back)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;COMPANY CONFIG
(add-hook 'after-init-hook 'global-company-mode);;company starts at boot


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

(setq company-require-match 'never)
(setq
 company-selection-wrap-around t
 company-tooltip-flip-when-above t
 company-tooltip-align-annotations t
 company-tooltip-offset-display 'lines
 company-minimum-prefix-length 0
 company-idle-delay nil
 company-lighter-base t
 company-global-modes '(not erc-mode message-mode eshell-mode)
 company-frontends '(company-pseudo-tooltip-frontend
		     company-preview-frontend
		     company-echo-metadata-frontend))

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-capf))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;QUICKCOMPANY
(unless (package-installed-p 'company-quickhelp)
  (package-install 'company-quickhelp))
(company-quickhelp-mode)
(setq company-quickhelp-delay nil)
(eval-after-load 'company
  '(define-key company-active-map (kbd "<f1>") #'company-quickhelp-manual-begin))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

(setq evil-emacs-state-cursor '((bar . 2)))

;; evil is not optimal for some modes
(setq evil-default-state 'normal)
(evil-set-initial-state 'vterm-mode 'emacs)
(evil-set-initial-state 'electric-buffer-menu-mode 'emacs)
(evil-set-initial-state 'Info-mode 'emacs)
(evil-set-initial-state 'help-mode 'motion)

;; custom keybidings for evil
(define-key evil-insert-state-map (kbd "C-h") 'left-char)
(define-key evil-insert-state-map (kbd "C-j") 'next-line)
(define-key evil-insert-state-map (kbd "C-k") 'previous-line)
(define-key evil-insert-state-map (kbd "C-l") 'right-char)
(define-key evil-visual-state-map (kbd "-") #'(lambda ()
                                                (interactive)
                                                (evil-end-of-line)
                                                (evil-backward-char)))


(define-key evil-normal-state-map (kbd "}") #'(lambda ()
                                                (interactive)
                                                (evil-forward-paragraph)
                                                (redraw-display)))
(define-key evil-normal-state-map (kbd "{") #'(lambda ()
                                                (interactive)
                                                (evil-backward-paragraph)
                                                (redraw-display)))

(define-key evil-normal-state-map (kbd "-") 'evil-end-of-line)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;C
(add-hook 'c-mode-hook (lambda () (c-set-style "stroustrup")))

(defun c-save-and-compile()
  (interactive)
  (save-buffer)
  (recompile))

(add-hook 'c-mode-hook
          (lambda ()
            (keymap-local-set "<f5>" #'c-save-and-compile)
            (keymap-local-set "<f7>" #'gud-gdb)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;VTERM


(if (eq system-type 'gnu/linux)
    (progn
      (use-package vterm
        :ensure t)
      (setq vterm-shell "/usr/bin/bash")
      (define-key vterm-mode-map (kbd "<f9>") 'bookmark-bmenu-list)
      (define-key vterm-mode-map (kbd "<f12>") 'delete-window)

      (setq initial-buffer-choice #'vterm)
      (define-key global-map (kbd "<f12>") 'vterm)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(eq system-type 'gnu/linux)
