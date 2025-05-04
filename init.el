(add-to-list 'load-path
	     (expand-file-name(concat user-emacs-directory "lisp")))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'init-ui)
(require 'init-packages)
(require 'init-kaomoji-title-bar)
(require 'init-aweshell)
(require 'init-lsp-bridge)
(require 'init-transient)
(require 'init-aidermacs)
(require 'init-editing)
(require 'init-magit)
(require 'init-dashboard)
(require 'init-pair)
(require 'init-sort-tab)
(require 'init-doom-modeline)
(require 'init-treemacs)
(require 'init-ace-window)
(require 'init-alpha)


