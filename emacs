;: Emacs configuration file

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;: Configure use package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
 (require 'use-package))

;: Packages
(use-package exec-path-from-shell
  :config
   (when (memq window-system '(mac ns))
     (exec-path-from-shell-initialize)))

(use-package markdown-mode
  :ensure t)
(use-package helm
  :ensure t)
(use-package neotree
   :ensure t)
(use-package projectile
   :ensure t)
(use-package yasnippet
   :ensure t)
(use-package magit
  :ensure t)
(use-package company
  :ensure t)
(use-package flycheck
  :ensure t)
(use-package elpy
  :ensure t)
(use-package evil
  :ensure t)
(use-package better-defaults
  :ensure t)
;; (use-package material-theme
;;   :ensure t)
(use-package zenburn-theme
   :ensure t)

;;
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'arrow 'arrow))

;;Interface
(xterm-mouse-mode)


;; Emacs theme 
;;(load-theme 'material t)
(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (spaceline-emacs-theme))
;; Get rid of anoying bezel on the mode-line
(load-theme 'zenburn t)
(set-face-attribute 'mode-line nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)

;; HELM Set Up
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(define-key helm-find-files-map "\t" 'helm-execute-persistent-action)
(set-face-attribute 'helm-header nil :box nil)
(set-face-attribute 'helm-source-header nil :box nil)

;; ;; IDO
;; (require 'ido)
;; (ido-mode t)


(evil-mode t)
(setq evil-insert-state-map (make-sparse-keymap))
(define-key evil-insert-state-map (kbd "<escape>") 'evil-normal-state)
;; Rebind neotree commands
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)

;; Python configuration
;; -------------------
(elpy-enable)
(elpy-use-ipython)
(require 'python)
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--simple-prompt -i")
(setq python-shell-completion-native-enable nil)
;; Jedi has default rope for refactoring
(setq elpy-rpc-backend "jedi")
(use-package ein
  :config
  (require 'ein))

;; Line number configuration
(require 'linum)
(global-linum-mode t)
(setq linum-format "%d ")

;; Save location
(setq backup-directory-alist `(("." . "~/.saves")))

                    
(setq tramp-default-method "ssh")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/org.test")))
 '(package-selected-packages
   (quote
    (yaml-mode ein zenburn-theme use-package spaceline projectile neotree markdown-mode magit helm flycheck exec-path-from-shell evil elpy better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
