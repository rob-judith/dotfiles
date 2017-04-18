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
  :defer
  :ensure t)
(use-package helm
  :config
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
)

(use-package neotree
  :defer
  :ensure t
  :config
  (require 'neotree)
  (global-set-key [f8] 'neotree-toggle)
  (setq neo-theme (if (display-graphic-p) 'arrow 'arrow))
  )

(use-package projectile
   :defer
   :ensure t)
(use-package yasnippet
   :defer
   :ensure t)
(use-package magit
  :defer
  )
(use-package company
  :defer
  :ensure t
)
(use-package flycheck
  :ensure t)
(use-package evil
  :ensure t)
(use-package better-defaults
  :ensure t)
(use-package zenburn-theme
   :ensure t)

;;Mouse Interface
(xterm-mouse-mode)
(defun scroll-up-10-lines ()
  "Scroll up 10 lines"
  (interactive)
  (scroll-up 10))

(defun scroll-down-10-lines ()
  "Scroll down 10 lines"
  (interactive)
  (scroll-down 10))

(global-set-key (kbd "<mouse-4>") 'scroll-down-10-lines) ;
(global-set-key (kbd "<mouse-5>") 'scroll-up-10-lines) ;
;; on Linux, make Control+wheel do increase/decrease font size
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)

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

(evil-mode t)
(setq evil-insert-state-map (make-sparse-keymap))
(define-key evil-insert-state-map (kbd "<escape>") 'evil-normal-state)
(define-key evil-insert-state-map (kbd "C-c C-k") 'evil-insert-digraph)

;; Rebind neotree commands
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)

;; Python configuration
;; -------------------
;; (use-package elpy
;;   :ensure t)
;; (elpy-enable)
;; (elpy-use-ipython)
;; (setq elpy-test-runner 'elpy-test-pytest-runner)
;; ;; Jedi has default rope for refactoring
;; (setq elpy-rpc-backend "jedi")
(require 'python)
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--simple-prompt -i")
(setq python-shell-completion-native-enable nil)
(use-package ein
  :defer
  :config
  (require 'ein))
;; Python specific settings
(use-package anaconda-mode
  :defer
  :ensure t
  )
(use-package company-anaconda
  :ensure t
  :after company
  :config
  (add-to-list 'company-backends 'company-anaconda))
(use-package pyvenv
  :defer
  :ensure t
  )
(use-package pytest
  :defer
  :ensure t)

(defun my-python-settings ()
  "Configure python mode."
  (linum-mode 1)
  (anaconda-mode 1)
  (anaconda-eldoc-mode 1)
  (company-mode 1)
  (pyvenv-mode 1)
  (pyvenv-workon "develop"))
(add-hook 'python-mode-hook 'my-python-settings)

;; Line number configuration
(require 'linum)
(global-linum-mode 0)
(setq linum-format "%d ")

;;Flycheck global mode
(global-flycheck-mode)

;; Save location
(setq backup-directory-alist `(("." . "~/.saves")))
(setq auto-save-file-name-transforms
      `((".*"  "~/.saves/" t)))

                    
(setq tramp-default-method "ssh")

