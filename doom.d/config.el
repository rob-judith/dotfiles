;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Robert Judith"
      user-mail-address "rob.judith@infiniaml.com")

;; Sane behavior for hjk with wrapped lines.
;; This doesn't seem to work with hjkl but does with end of line commands
;; which is the worse of both world. Disabling
;; (setq evil-respect-visual-line-mode t)

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Fira Code" :size 12))

;; This is because vsync is now the standard may drop if it doesn't seem to be doing anything
;; (add-to-list 'default-frame-alist '(inhibit-double-buffering . t))


;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq ispell-personal-dictionary "/home/robjudith/.aspell.en.pws")

(after! org-roam (setq org-roam-graph-viewer  "/usr/bin/google-chrome"))

(after! git-gutter
  (setq git-gutter:disabled-modes '(org-mode))
  )

(after! org
        (org-babel-do-load-languages 'org-babel-load-languages
                                     '((mermaid . t)))
        (setq org-todo-keywords '(
                (sequence "TODO" "IN-PROGRESS" "IN-REVIEW" "BLOCKED" "DELEGATED" "|" "DONE")
                (sequence "|" "WONT-DO")
                ))

        (setq org-todo-keyword-faces '(
                ("IN-PROGRESS" . +org-todo-active)
                ("IN-REVIEW" . +org-todo-onhold)
                ("BLOCKED" . +org-todo-cancel)
                ("DELEGATED" . +org-todo-onhold)
                ))

      (setq org-capture-templates '(
                ("t" "Personal todo" entry (file+headline +org-capture-todo-file "Inbox") "* TODO %? %i %a" :prepend t)
                ("n" "Personal notes" entry (file+headline +org-capture-notes-file "Inbox") "* %u %? %i %a" :prepend t)
                ("q" "Personal notes no loc" entry (file+headline +org-capture-notes-file "Inbox") "* %u %? %i" :prepend t)
                ("j" "Journal" entry (file+olp+datetree +org-capture-journal-file) "* %U %?\n%i" :prepend t)
                ("p" "Pain Point" entry (file+headline +org-capture-notes-file "Painpoints") "* %u %^{Title} :painpoint:\n%i\n %?" :prepend t)
                ("o" "Centralized templates for projects")
                        ("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %? %i %a" :heading "Tasks" :prepend nil)
                        ("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %? %i %a" :heading "Notes" :prepend t)
                        ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %? %i %a" :heading "Changelog" :prepend t)
                ))
      (setq org-id-link-to-org-use-id t)

      )

(eval-after-load "org"
  '(require 'ox-gfm nil t))

(defun jira-link (ticket)
    "From a ticket title generate a jira link"
    (interactive "sTicket:")
    (insert (format "[[https://jira.infiniaml.net/browse/%s][%s]]" ticket ticket)))

;; (define-key org-mode-map (kbd "C-c j") 'jira-link)
;; Old way Johnny
(add-hook 'org-mode-hook
  (lambda ()
  (local-set-key (kbd "C-c j") 'jira-link)))

 ;; (grep-apply-setting
 ;;   'grep-find-command
 ;;   '("rg -n -H --no-heading -e ''" . 27)
 ;; )
;; Configure org download so I can insert images
;; (use-package! org-download)
;; (add-hook 'dired-mode-hook 'org-download-enable)
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
