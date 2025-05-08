(add-to-list 'load-path "~/.emacs.d/site-lisp/aweshell")


(require 'aweshell)
(add-hook 'aweshell-mode-hook 'company-mode)
(global-set-key (kbd "C-c t") 'aweshell-new)


(provide 'init-aweshell)
