;; treemacs
(add-to-list 'load-path "~/.emacs.d/site-lisp/treemacs/src/elisp")
(require 'treemacs)

(add-to-list 'load-path "~/.emacs.d/site-lisp/nerd-icons.el")
(require 'nerd-icons)

(add-to-list 'load-path "~/.emacs.d/site-lisp/treemacs-nerd-icons")
(require 'treemacs-nerd-icons)

(treemacs-load-theme "nerd-icons")
(setq treemacs-follow-mode t
      treemacs-filewatch-mode t
      treemacs-fringe-indicator-mode 'always
      treemacs-width 22)

;; keybinding
(global-set-key (kbd "C-x B") 'treemacs)
(global-set-key (kbd "C-x t 1") 'treemacs-delete-other-windows)
(global-set-key (kbd "M-0") 'treemacs-select-window)
(global-set-key (kbd "C-x t d") 'treemacs-select-directory)
(global-set-key (kbd "C-x f") 'treemacs-find-file)

(defvar my-treemacs-font-family "hack"
  "Font family used in Treemacs.")

(setq treemacs-indentation 1)

(with-eval-after-load 'treemacs
  (set-face-attribute 'treemacs-directory-face nil :height 0.8 :family my-treemacs-font-family)
  (set-face-attribute 'treemacs-file-face nil :height 0.8 :family my-treemacs-font-family)
  (set-face-attribute 'treemacs-directory-collapsed-face nil :height 0.8 :family my-treemacs-font-family)
  (set-face-attribute 'treemacs-root-face nil :height 1.1 :family my-treemacs-font-family)
  (set-face-attribute 'treemacs-root-unreadable-face nil :height 1.1 :family my-treemacs-font-family)
  (set-face-attribute 'treemacs-git-modified-face nil :height 0.8 :family my-treemacs-font-family)
  (set-face-attribute 'treemacs-git-added-face nil :height 0.8 :family my-treemacs-font-family)
  (set-face-attribute 'treemacs-git-untracked-face nil :height 0.8 :family my-treemacs-font-family)
  (set-face-attribute 'treemacs-git-ignored-face nil :height 0.8 :family my-treemacs-font-family)
  (set-face-attribute 'treemacs-async-loading-face nil :height 0.8 :family my-treemacs-font-family)
)

(provide 'init-treemacs)
