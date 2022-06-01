;;; init.el --- personal emacs customization
;;; Commentary:
;;; search online

;;; Code:

;; basic customization (built-in)
(setq inhibit-startup-message t)
;; message in *scratch* buffer
(setq initial-scratch-message nil)

;; use git instead of backup files
(setq auto-save-default nil)
(setq make-backup-files nil)

;; no noise
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)


;; auto revert mode
(global-auto-revert-mode 1)
;; auto refresh dired when file changes
(add-hook 'dired-mode-hook 'auto-revert-mode)

;; make full screen by default
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; line numbers and 80 column rule in all major programming modes
(global-display-line-numbers-mode t)
(column-number-mode t)
(setq-default fill-column 80)
(add-hook 'prog-mode-hook #'auto-fill-mode)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

;;; package manager
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)
;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))


;; easier life
(use-package ido
  :ensure t
  :config
  (ido-mode 1)
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (defalias 'list-buffers 'ibuffer))

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0)))))
    ))

;; org configure
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; search
(use-package counsel
  :ensure t
  )

(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy))


(use-package swiper
  :ensure try
  :bind (("C-s" . swiper)
	 ("C-r" . swiper)
	 ("C-c C-r" . ivy-resume)
	 ("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))

;; navigation
(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char))

;; programming related
;; syntax check
(use-package flycheck
  :defer t
  :ensure t
  :hook (after-init . global-flycheck-mode)
  )

;; auto complete frontend
(use-package company
  :ensure t
  :hook (prog-mode . company-mode)
  :custom
  (company-minimum-prefix-length 3)
  ;; Trigger completion immediately
  (company-idle-delay 0.1)
  ;; Number the candidates (use M-1, M-2 etc to select completions).
  (company-show-numbers t)
  :config
  (global-company-mode 1))

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))

;; auto complete backend with lsp
(use-package lsp-mode
  :ensure t
  :defer t
  :custom
  (lsp-keymap-prefix "C-x l")
  (lsp-auto-guess-root nil)
  (lsp-prefer-flymake nil)
  :hook ((c-mode c++-mode) . lsp-deferred))

(use-package lsp-ui
  :after lsp-mode
  :ensure t)

;; debug
(use-package gdb-mi
  :ensure t
  :config
  (setq gdb-many-windows t))

;; template system
(use-package yasnippet
  :ensure t
  :bind
  ("C-c y s" . yas-insert-snippet)
  ("C-c y v" . yas-visit-snippet-file)
  :config
  (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
  (yas-global-mode 1))

;; git
(use-package magit
  :ensure t)
