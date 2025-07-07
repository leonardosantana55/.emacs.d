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
   '(ac-slime auto-complete cl-libify company evil slime slime-company))
 '(tool-bar-mode nil))


(custom-set-faces
;;change font based on if emacs is running on linux or not
(let ((font-name (if (eq system-type 'gnu/linux)
		      "Noto Sans Mono"
		      "Cascadia Mono")))
  `(default ((t (:family ,font-name :foundry "outline" :slant normal :weight regular :height 120 :width normal))))))

;; (custom-set-face
;;  (if (eq system-type 'gnu/linux)
;;      '(default ((t (:family "Noto Sans Mono"
;; 			    :foundry "GOOG"
;; 			    :slant normal
;; 			    :weight regular
;; 			    :height 120
;; 			    :width normal))))
;;      '(default ((t (:family "Cascadia Mono"
;; 			  :foundry "outline"
;; 			  :slant normal
;; 			  :weight regular
;; 			  :height 120
;; 			  :width normal))))))


(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(setq dired-kill-when-opening-new-dired-buffer 1)
;(show-paren-mode)
(setq help-window-select t)  ; Switch to help buffers automatically
(electric-pair-mode t)

					;key bindings

;;TODO ao rodar commando com M-! pular foco para a janela de output.
;;(para facilitar fechar o novo buffer criado)

;; sair do minibuffer com C-[


;(keymap-global-set "C-v" 'clipboard-yank)
;(keymap-global-set "C-z" 'kill-ring-save)
(keymap-global-set "C-c b" 'ibuffer)
(keymap-global-set
 ;Load init.el
 "C-c l i"
 (lambda ()
   (interactive)
   (load-file (expand-file-name "~/.emacs.d/init.el"))))

					;package manager

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

					;slime

(setq inferior-lisp-program "sbcl")
;(setq inferior-lisp-program "/opt/sbcl/bin/sbcl")
(require 'slime-autoloads)
(slime-setup '(slime-fancy slime-company))
;(slime-setup '(slime-fancy slime-quicklisp slime-asdf slime-mrepl slime-banner slime-autodoc slime-fuzzy slime-editing-commands))

(add-hook 'lisp-mode-hook
	  (lambda () (keymap-local-set "C-c e b" #'slime-eval-buffer)))

;(keymap-global-set "C-c e b" #'slime-eval-buffer)

					;Company config

(add-hook 'after-init-hook 'global-company-mode)

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



					;Evil mode

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(setq evil-disable-insert-state-bindings t)
(require 'evil)
(evil-mode 1)

(setq evil-default-state 'insert)

;; (setq evil-default-state 'emacs)
;; (evil-set-initial-state 'shell-mode 'emacs)
;; ;(evil-set-initial-state 'slime-repl-mode 'emacs)
;; (evil-set-initial-state 'Info-mode 'emacs)
;; (evil-set-initial-state 'fundamental-mode 'emacs)

;; (setq evil-emacs-state-cursor 'bar)

;; (defun my-evil-change-advice (orig-fun &rest args)
;;   "Advice around `evil-change` to enter Emacs state after change."
;;   (apply orig-fun args)       ;; perform the original change operation
;;   (evil-normal-state)         ;; exit insert state (ESC)
;;   (evil-emacs-state)         ;; switch to Emacs state (C-z)
;;   (forward-char 1))           ;; move cursor one character to the right

;; (advice-add 'evil-change :around #'my-evil-change-advice)

;; (defun my-evil-insert-advice (orig-fun &rest args)
;;   "Advice around `evil-insert` to enter Emacs state after change."
;;   (apply orig-fun args)       ;; perform the original change operation
;;   (evil-normal-state)         ;; exit insert state (ESC)
;;   (evil-emacs-state)         ;; switch to Emacs state (C-z)
;;   (backward-char 1)
  
;; (advice-add 'evil-insert :around #'my-evil-change-advice)





;; Setup load-path and autoloads
;(add-to-list 'load-path "~/dir/to/cloned/slime")


;; Set your lisp system and some contribs
;(setq slime-contribs '(slime-scratch slime-editing-commands))
;(add-to-list 'slime-contribs 'slime-repl)










































;; (setq inferior-lisp-program "sbcl")

;; (require 'slime)
;; (slime-setup '(slime-fancy slime-quicklisp slime-asdf slime-mrepl))

























































;; Use spaces, not tabs, for indentation.
;; (setq-default indent-tabs-mode nil)

;; Highlight matching pairs of parentheses.
;; (setq show-paren-delay 0)
;; (show-paren-mode)

;; ;; Install packages.
;; (dolist (package '(slime paredit rainbow-delimiters))
;;   (unless (package-installed-p package)
;;     (package-install package)))

;; ;; Enable Paredit.
;; (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
;; (add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
;; (add-hook 'ielm-mode-hook 'enable-paredit-mode)
;; (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
;; (add-hook 'lisp-mode-hook 'enable-paredit-mode)
;; (add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
;; (require 'paredit)
;; (defun override-slime-del-key ()
;;   (define-key slime-repl-mode-map
;;     (read-kbd-macro paredit-backward-delete-key) nil))
;; (add-hook 'slime-repl-mode-hook 'override-slime-del-key)

;; ;; Enable Rainbow Delimiters.
;; (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
;; (add-hook 'ielm-mode-hook 'rainbow-delimiters-mode)
;; (add-hook 'lisp-interaction-mode-hook 'rainbow-delimiters-mode)
;; (add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
;; (add-hook 'slime-repl-mode-hook 'rainbow-delimiters-mode)

;; Customize Rainbow Delimiters.
;; (require 'rainbow-delimiters)
;; (set-face-foreground 'rainbow-delimiters-depth-1-face "#c66")  ; red
;; (set-face-foreground 'rainbow-delimiters-depth-2-face "#6c6")  ; green
;; (set-face-foreground 'rainbow-delimiters-depth-3-face "#69f")  ; blue
;; (set-face-foreground 'rainbow-delimiters-depth-4-face "#cc6")  ; yellow
;; (set-face-foreground 'rainbow-delimiters-depth-5-face "#6cc")  ; cyan
;; (set-face-foreground 'rainbow-delimiters-depth-6-face "#c6c")  ; magenta
;; (set-face-foreground 'rainbow-delimiters-depth-7-face "#ccc")  ; light gray
;; (set-face-foreground 'rainbow-delimiters-depth-8-face "#999")  ; medium gray
;; (set-face-foreground 'rainbow-delimiters-depth-9-face "#666")  ; dark gray





;; ;; a list of alternative Common Lisp implementations that can be
;; ;; used with SLIME. Note that their presence render
;; ;; inferior-lisp-program useless. This variable holds a list of
;; ;; programs and if you invoke SLIME with any prefix argument,
;; ;; like M-- M-x slime or C-u M-x slime, you can select a program
;; ;; from that list.
;; ;
;; (setq slime-lisp-implementations
;;       '((ccl ("ccl"))
;;         (clisp ("clisp" "-q"))
;;         (sbcl ("sbcl" "--noinform") :coding-system utf-8-unix)))

;; ;; select the default value from slime-lisp-implementations
;; (if (eq system-type 'darwin)
;;     ;; default to Clozure CL on OS X
;;     (setq slime-default-lisp 'ccl)
;;   ;; default to SBCL on Linux and Windows
;;   (setq slime-default-lisp 'sbcl))

;; ;; If you use Prelude:
;; ; (add-hook 'lisp-mode-hook (lambda () (run-hooks 'prelude-lisp-coding-hook)))
;; ; (add-hook 'slime-repl-mode-hook (lambda () (run-hooks 'prelude-interactive-lisp-coding-hook)))

;; ;; start slime automatically when we open a lisp file
;; (defun prelude-start-slime ()
;;   (unless (slime-connected-p)
;;     (save-excursion (slime))))

;; (add-hook 'slime-mode-hook 'prelude-start-slime)

;; ;; Stop SLIME's REPL from grabbing DEL,
;; ;; which is annoying when backspacing over a '('
;; (defun prelude-override-slime-repl-bindings-with-paredit ()
;;   (define-key slime-repl-mode-map
;;     (read-kbd-macro paredit-backward-delete-key) nil))

;; (add-hook 'slime-repl-mode-hook 'prelude-override-slime-repl-bindings-with-paredit)

;; (eval-after-load "slime"
;;   '(progn
;;      (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol
;;            slime-fuzzy-completion-in-place t
;;            slime-enable-evaluate-in-emacs t
;;            slime-autodoc-use-multiline-p t)

;;      (define-key slime-mode-map (kbd "TAB") 'slime-indent-and-complete-symbol)
;;      (define-key slime-mode-map (kbd "C-c i") 'slime-inspect)
;;      (define-key slime-mode-map (kbd "C-c C-s") 'slime-selector)))

;; ; (setq slime-completion-at-point-functions (list 'completion-at-point))

;; (global-company-mode 1)

;; (add-hook 'slime-mode-hook 'set-up-slime-ac)
;; (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
;; (eval-after-load "auto-complete"
;;   '(add-to-list 'ac-modes 'slime-repl-mode))
