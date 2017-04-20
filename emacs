;;; EmacsConfig --- Emacs Configuration file

;;; Commentary:
;;; Emacs Configuration file.  This is kinda a mess right now.

;;; Code:

;;--------------------------------------------------------------------------------
;;                             Initial Setup
;;--------------------------------------------------------------------------------

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

(use-package exec-path-from-shell
  :config
   (when (memq window-system '(mac ns))
     (exec-path-from-shell-initialize)))

;;--------------------------------------------------------------------------------
;;                             Packages
;;--------------------------------------------------------------------------------

(use-package markdown-mode
  :defer
  :ensure t)

(use-package helm
  :config
  (require 'helm-config)
  (global-set-key (kbd "M-x") #'helm-M-x)
  (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
  (global-set-key (kbd "C-x C-f") #'helm-find-files)
  (setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
  ;; Recomended Remaps
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
  (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)
  (setq helm-autoresize-max-height 0)
  (setq helm-autoresize-min-height 20)
  (helm-autoresize-mode 1)
  (helm-mode 1))


(use-package projectile
   :defer
   :ensure t)

(use-package helm-projectile
  :defer
  :ensure t
  :after projectile
  :config
  (require 'helm-projectile)
  (helm-projectile-on))

(use-package yasnippet
   :defer
   :ensure t)

(use-package magit
  :defer
  :ensure t)

(use-package company
  :defer
  :ensure t
  :config
  (global-company-mode)
  (setq company-idle-delay .3))

(use-package auto-complete
  :defer)

(use-package flycheck
  :ensure t
  :config
  ;;Flycheck global mode
  (global-flycheck-mode))

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key "<SPC>" 'helm-M-x)
  (evil-leader/set-key "f" 'helm-find-files)
  (evil-leader/set-key "b" 'switch-to-buffer)
  (evil-leader/set-key "k" 'kill-buffer)
  (evil-leader/set-key "m" 'helm-bookmarks)
  (evil-leader/set-key "g" 'magit-status)
  (evil-leader/set-key "p f" 'helm-projectile-find-file)
  (evil-leader/set-key "p p" 'projectile-mode)
  (evil-leader/set-key "p h" 'helm-projectile))

(use-package evil
  :after evil-leader
  :ensure t
  :config
  (evil-mode t)
  ;; Make insert mode like standard emacs
  (setq evil-insert-state-map (make-sparse-keymap))
  (define-key evil-insert-state-map (kbd "<escape>") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-c C-k") 'evil-insert-digraph))

(use-package neotree
  :defer
  :after evil
  :ensure t
  :config
  (require 'neotree)
  (global-set-key [f8] 'neotree-toggle)
  (setq neo-theme (if (display-graphic-p) 'arrow 'arrow))
  ;; Rebind neotree commands
  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter))

(use-package better-defaults
  :ensure t)

;;--------------------------------------------------------------------------------
;;                               Theaming
;;--------------------------------------------------------------------------------

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (spaceline-emacs-theme)
  (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
  ;; Because I'm super picky about my colors.
  (set-face-background 'spaceline-evil-insert "MediumSeaGreen")
  (set-face-background 'spaceline-evil-normal "MediumOrchid3"))

;; (use-package smart-mode-line
;;   :ensure t
;;   :config
;;   (sml/setup))

;; (use-package powerline
;;   :ensure t
;;   :config
;;   (require 'powerline))

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (load-theme 'sanityinc-tomorrow-eighties))

;;--------------------------------------------------------------------------------
;;                          Python configuration
;;--------------------------------------------------------------------------------

(require 'python)
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--simple-prompt -i")
(setq python-shell-completion-native-enable nil)

(use-package anaconda-mode
  :defer
  :ensure t)
(use-package company-anaconda
  :ensure t
  :after company
  :config
  (add-to-list 'company-backends 'company-anaconda))
;; (use-package company-jedi
;;   :ensure t)

;; (use-package elpy
;;   :ensure t
;;   :config
;;   (elpy-enable)
;;   (elpy-use-ipython)
;;   (setq elpy-test-runner 'elpy-test-pytest-runner)
;;   Jedi has default rope for refactoring
;;   (setq elpy-rpc-backend "jedi"))

(use-package pyvenv
  :defer
  :ensure t
  :config
  (setenv "WORKON_HOME" "~/envs/"))
;; (use-package pytest
;;   :defer
;;   :ensure t)

(use-package ein
  :defer
  :config
  (require 'ein)
  (require 'ein-loaddefs)
  (require 'ein-notebook)
  (require 'ein-subpackages)
  (setq ein:default-url-or-port "http://localhost:9667/")
  (setq ein:url-or-port '("http://localhost:8888/"
                          "http://192.168.111.1:9666/"
                          "http://192.168.111.2:9666/"))
  )

(defun my-python-settings ()
  "Configure python mode."
  (linum-mode 1)
  ;; (anaconda-mode 1)
  ;; (anaconda-eldoc-mode 1)
  (company-mode 1)
  ;;(add-to-list 'company-backend 'company-jedi)
  (pyvenv-mode 1)
  (pyvenv-workon "develop")
  (electric-pair-mode 1))

(add-hook 'python-mode-hook 'my-python-settings)
(add-hook 'compilation-mode-hook 'ansi-color-for-comint-mode-on)

;;--------------------------------------------------------------------------------
;;                         Misc. Settings
;;--------------------------------------------------------------------------------
(xterm-mouse-mode)
(defun scroll-up-10-lines ()
  "Scroll up 10 lines."
  (interactive)
  (scroll-up 10))

(defun scroll-down-10-lines ()
  "Scroll down 10 lines."
  (interactive)
  (scroll-down 10))

(global-set-key (kbd "<mouse-4>") 'scroll-down-10-lines) ;
(global-set-key (kbd "<mouse-5>") 'scroll-up-10-lines) ;

;;End Mouse Settings

;;Visual Bell
(defun my-terminal-visible-bell ()
   "A friendlier visual bell effect."
   (invert-face 'mode-line)
   (run-with-timer 0.1 nil 'invert-face 'mode-line))
 
(setq visible-bell nil)
(setq ring-bell-function 'my-terminal-visible-bell)

;; Line number configuration
(require 'linum)
(global-linum-mode 0)
(setq linum-format "%d ")
;; Save location
(setq backup-directory-alist `(("." . "~/.saves")))
(setq auto-save-file-name-transforms
      `((".*"  "~/.saves/" t)))


(setq tramp-default-method "ssh")
;;; Emacs ends here
