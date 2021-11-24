(add-to-list 'load-path
	     (expand-file-name(concat user-emacs-directory "lisp")))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'init-startup)
(require 'init-elpa)
(require 'init-ui)
(require 'init-package)
(require 'init-scheme)
(require 'init-paredit)
(require 'init-action)
(require 'init-keybindings)
(require 'init-func)
(require 'init-terminal)

(require 'init-dashboard)
(require 'init-eaf)
(require 'init-pair)

;; use org-mode control .emacs.d

;; (require 'org-install)
;; (require 'ob-tangle)
;; (org-babel-load-file (expand-file-name "org-file-name.org" user-emacs-directory))


