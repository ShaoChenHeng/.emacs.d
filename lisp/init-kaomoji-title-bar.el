;; kaomoji title bar
(add-to-list 'load-path "~/.emacs.d/site-lisp/kaomoji-title-bar")
(require 'kaomoji-title-bar)
(kaomoji-title-bar-set-default-style 'ciallo)
(kaomoji-title-bar 1)

(provide 'init-kaomoji-title-bar)
