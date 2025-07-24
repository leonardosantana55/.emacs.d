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
   '("90903f9847cdccac16cc658dd06ae8906bccdf73327952d17b65633d9508fa71"
     "e5c58b45a93d2f9f87e727d8d2b17ce7ba792d12cee6ecef6e27b5b2ea25c60e"
     "fc809f7a044fefc09dbacf8170083a7957c21d53e1a0cc3146fcfe5d65747f9c"
     default))
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(ac-slime cl-libify company-anaconda elpy elpygen evil paredit
              rainbow-delimiters slime-company))
 '(tool-bar-mode nil))


;;;EMACS CUSTOM OPTIONS
(setq blink-cursor-blinks 0) 
(column-number-mode t); show column number on mode line
(icomplete-mode 1); show completion on the minibuffer
(setq completions-format 'one-column); or 'horizontal, or 'one-column
(setq completion-auto-select 'second-tab); Focus on completions buffer 
(setq cursor-in-non-selected-windows nil) ; show cursor only in the active window
(setq-default indent-tabs-mode nil); Use spaces, not tabs, for indentation.
(setq doc-view-scale-internally t)
(setq doc-view-resolution 300)
(scroll-bar-mode -1); hide scrool bar
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


;;;KEY BINDINGS
(keymap-global-set "C-c b" 'ibuffer)
(keymap-global-set
 ;Load init.el
 "C-c l i"
 (lambda ()
   (interactive)
   (load-file (expand-file-name "~/.emacs.d/init.el"))))

(keymap-global-set
 ;function for updating the file on github
 "C-c g p f"
 (lambda ()
   (interactive)
   (shell-command
    (format "git add %s && git commit -m \"emacs\" && git push"
            (buffer-name)))))


;;;PACKAGE MANAGER
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


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
