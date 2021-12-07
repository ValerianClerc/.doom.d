;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Valerian Clerc"
      user-mail-address "valerian.clerc@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; The following configuration variables were added by me (Valerian)
(setq
 projectile-project-search-path '("~/coding")
 haskell-stylish-on-save t
 ;;mac-command-modifier 'meta
 dired-dwim-target t
 org-cycle-emulate-tab nil
 )

(after! haskell-interactive-mode
  (map! :nvie "C-j" #'haskell-interactive-mode-history-next)
  (map! :nvie "C-k" #'haskell-interactive-mode-history-previous)
  )

(after! evil
  (map! :nvie "s-/" #'evilnc-comment-or-uncomment-lines)
  )

(after! org
  (map! :map org-mode-map
        :n "s-j" #'org-metadown
        :n "s-k" #'org-metaup)
  (setq
   org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))
   org-todo-keyword-faces
   '(("WAITING" :foreground "#9f7efe" :weight normal :underline t)
     ("INPROGRESS" :foreground "#0098dd" :weight normal :underline t)
     ("DONE" :foreground "#50a14f" :weight normal :underline t)
     ("CANCELLED" :foreground "#ff6480" :weight normal :underline t)
     ))
  )

;; hook to prevent formatting with LSP in cases where theres a specific formatter requested (i.e. prettier)
;; This is to prevent 2 formatters trying to modify the same file
(add-hook! 'typescript-mode-hook
  (if (locate-dominating-file default-directory ".prettierrc.js")
      (setq +format-with-lsp nil)
    (setq +format-with-lsp t))
  )
