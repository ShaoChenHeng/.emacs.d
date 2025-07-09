(add-to-list 'load-path "~/.emacs.d/site-lisp/copilot.el")
(require 'copilot)
;;(add-hook 'prog-mode-hook 'copilot-mode)
(add-hook 'pyton-mode-hook 'copilot-mode)
(add-hook 'js-mode-hook 'copilot-mode)
(add-hook 'web-mode-hook 'copilot-mode)

(add-to-list 'copilot-indentation-alist '(prog-mode 2))
(add-to-list 'copilot-indentation-alist '(web-mode 2))
(add-to-list 'copilot-indentation-alist '(python-mode 2))
(add-to-list 'copilot-indentation-alist '(js2-mode 2))
(add-to-list 'copilot-indentation-alist '(java-mode 2))

;; 全部补全
(define-key copilot-completion-map (kbd "M-?") 'copilot-accept-completion)
;; 按字接受 Copilot 补全
(define-key copilot-completion-map (kbd "M-'") 'copilot-accept-completion-by-word)

(custom-set-faces
 '(copilot-overlay-face ((t (:foreground "#d3edcf" :background "#406539" :italic t)))))

(provide 'init-copilot)
