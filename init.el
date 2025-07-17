;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wombat))
 '(global-display-line-numbers-mode t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(ac-slime
     auto-complete
     cl-libify
     company
     evil
     slime
     slime-company))
 '(tool-bar-mode nil))

(custom-set-faces
;;change font based on OS
(let ((font-name (if (eq system-type 'gnu/linux)
		      "Noto Sans Mono"
		      "Cascadia Mono")))
  `(default ((t (:family ,font-name
                         :foundry "outline"
                         :slant normal
                         :weight regular
                         :height 120
                         :width normal))))))


;;;EMACS CUSTOM OPTIONS
(column-number-mode t); show column number on mode line
(icomplete-mode 1)
(setq completions-format 'one-column); or 'horizontal, or 'one-column
(setq completion-auto-select 'second-tab); Focus on completions buffer 
(setq cursor-in-non-selected-windows nil) ; show cursor only in the active window
(setq-default indent-tabs-mode nil); Use spaces, not tabs, for indentation.
(setq doc-view-scale-internally t)
(setq doc-view-resolution 300)
(scroll-bar-mode -1)
(setq scroll-margin 4)
(setq scroll-step 1)
(setq inhibit-startup-screen t)
(setq dired-kill-when-opening-new-dired-buffer 1)
(setq help-window-select t)  ; Switch to help buffers automatically
(electric-pair-mode t) ; Match parenthesis


;;;KEY BINDINGS
(keymap-global-set "C-c b" 'ibuffer)
(keymap-global-set
 ;Load init.el
 "C-c l i"
 (lambda ()
   (interactive)
   (load-file (expand-file-name "~/.emacs.d/init.el"))))


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

;; start slime automatically when we open a lisp file


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



