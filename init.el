;;; init.el --- personal emacs customization
;;; Commentary:
;;; search online

;;; Code:
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; disable menubar, toolbar and scrollbar
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; use git instead of backup files
(setq auto-save-default nil)
(setq make-backup-files nil)

;; make full screen by default
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; line numbers and 80 column rule in all major programming modes
(global-display-line-numbers-mode t)
(column-number-mode t)
(setq-default fill-column 80)
(add-hook 'prog-mode-hook #'auto-fill-mode)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

;; package manage
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
                         ("gnu"   . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

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
  (company-minimum-prefix-length 1)
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

;; template system
(use-package yasnippet
  :ensure t
  :bind
  ("C-c y s" . yas-insert-snippet)
  ("C-c y v" . yas-visit-snippet-file)
  :config
  (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
  (yas-global-mode 1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-show-quick-access t nil nil "Customized with use-package company")
 '(package-selected-packages
   '(yasnippet-snippets lsp-ui lsp-mode flycheck company-box company use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;; init.el ends here
