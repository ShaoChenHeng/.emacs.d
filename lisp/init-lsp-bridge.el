(add-to-list 'load-path "~/.emacs.d/site-lisp/lsp-bridge")

(add-to-list 'load-path "~/.emacs.d/site-lisp/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

(require 'lsp-bridge)

(global-lsp-bridge-mode)

(setq lsp-bridge-python-lsp-server "pyright")
(setq lsp-bridge-c-lsp-server "ccls")

(provide 'init-lsp-bridge)
