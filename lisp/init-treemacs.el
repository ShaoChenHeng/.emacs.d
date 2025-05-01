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
      treemacs-width 25)


;; keybinding
(global-set-key (kbd "C-x B") 'treemacs)
(global-set-key (kbd "C-x t 1") 'treemacs-delete-other-windows)
(global-set-key (kbd "M-0") 'treemacs-select-window)
(global-set-key (kbd "C-x t d") 'treemacs-select-directory)
(global-set-key (kbd "C-x f") 'treemacs-find-file)
;;(global-set-key (kbd "[mouse-1]") 'treemacs-single-click-expand-action)

(provide 'init-treemacs)
