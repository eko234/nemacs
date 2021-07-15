;; GC ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun bp-gc-after-init-hook ()
  "Lower GC params to avoid freezes."
  (interactive)
  (setq gc-cons-threshold (* 256 1024 1024)
        gc-cons-percentage 0.3))

(add-hook 'after-init-hook #'bp-gc-after-init-hook)

;; PACKAGES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(setq package-list
      '( use-package
	 fzf
	 visual-regexp
	 paredit
	 sly
	 lsp-python-ms
	 twilight-bright-theme
	 which-key
	 visual-regexp-steroids
	 projectile
	 ido
	 magit
	 company
	 company-fuzzy
	 direx
	 general
	 helm
	 paredit
	 which-key
	 treemacs
	 zones
	 fennel-mode
	 smex
	 slime
	 sly-asdf
	 python-mode
	 jedi
	 company-jedi
	 expand-region
	 counsel
	 treemacs-all-the-icons
	 elpy
	 minsk-theme
	 acme-theme
	 ))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; PRE-LOAD

(use-package display-line-numbers
  :init
  (menu-bar--display-line-numbers-mode-relative)
  (global-display-line-numbers-mode))


;; UI
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(use-package treemacs :defer t)
(use-package zones :defer t)
(require 'treemacs-all-the-icons)
(treemacs-load-theme "all-the-icons")


;; (use-package minsk-theme
;;   :when (display-graphic-p)
;;   :config (load-theme 'minsk t))

(use-package acme-theme
  :when (display-graphic-p)
  :config (load-theme 'acme t))


(use-package which-key
  :config (which-key-mode))

(use-package smex
  :config (global-set-key (kbd "M-x") 'smex))

(use-package slime)

(use-package company
  :ensure t
  :defer t
  :config
  (setq company-dabbrev-other-buffers t
	company-dabbrev-code-other-buffers t)
  :init (global-company-mode t)) 

(use-package company-fuzzy
  :ensure t
  :defer t
  :init (global-company-fuzzy-mode ))
 
(use-package paredit
  :ensure t
  :config
  (add-hook 'lisp-mode-hook #'paredit-mode)
  (add-hook 'emacs-lisp-mode-hook #'paredit-mode))  

(use-package paren
  :config
  (show-paren-mode +1))

(use-package elpy
  :ensure t
  :config (add-to-list
	   'company-backends
		       'elpy-company-backend)
  :init
  (elpy-enable))

(use-package lsp-python-ms
  :ensure t
  :init (setq lsp-python-ms-auto-install-server t)
  :hook (python-mode . (lambda ()
			 (require 'lsp-python-ms)
			 (lsp))))

(use-package python
  :ensure t
  :mode ("\\.py\\'" . python-mode)
  :config (add-to-list 'company-backends 'company-jedi)
  :interpreter ("python3" . python-mode))

(use-package emms
  :config
  (require 'emms-setup)
  (emms-all)
  (emms-default-players))


