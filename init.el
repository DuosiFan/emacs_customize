;;; init.el --- personal emacs customization
;;; Commentary:
;;; search online

;;; Code:

;; basic customization (built-in)
(setq inhibit-startup-message t)
;; message in *scratch* buffer
(setq initial-scratch-message nil)

;; no noise
(scroll-bar-mode -1)

;; use git instead of backup files
(setq auto-save-default nil)
(setq make-backup-files nil)

;; auto revert mode
(global-auto-revert-mode 1)
;; auto refresh dired when file change
(add-hook 'dired-mode-hook 'auto-revert-mode)

;; make full screen by default
(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)

;; ruler
(column-number-mode t)
(setq-default fill-column 81)
(global-display-fill-column-indicator-mode t)

;;; package manager
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
                         ("gnu"   . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-initialize)
;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

(use-package ido
  :ensure t
  :config
  (ido-mode)
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (defalias 'list-buffers 'ibuffer))

(use-package which-key
  :ensure t
  :init (which-key-mode))

(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0)))))
    ))

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))

;; auto complete frontend
(use-package company
  :ensure t
  :hook (prog-mode . company-mode)
  :custom
  (company-minimum-prefix-length 3)
  ;; Trigger completion immediately
  (company-idle-delay 0.1)
  ;; Number the candidates (use M-1, M-2 etc to select completions).
  (company-show-numbers t))

(use-package eglot
  :ensure t
  :hook ((c-mode . eglot-ensure)
	 (c++-mode . eglot-ensure)))

;; template system
(use-package yasnippet
  :ensure t
  :bind
  ("C-c y s" . yas-insert-snippet)
  ("C-c y v" . yas-visit-snippet-file)
  :config
  (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
  (yas-global-mode 1))

(use-package magit
  :ensure t)
;;; init.el ends here
