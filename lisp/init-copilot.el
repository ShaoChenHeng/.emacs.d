(add-to-list 'load-path "~/.emacs.d/site-lisp/copilot.el")
(require 'copilot)
;;(add-hook 'prog-mode-hook 'copilot-mode)
(add-hook 'pyton-mode-hook 'copilot-mode)
(add-hook 'js-mode-hook 'copilot-mode)
(add-hook 'web-mode-hook 'copilot-mode)
(add-hook 'python-ts-mode-hook 'copilot-mode)
(add-hook 'js-ts-mode-hook 'copilot-mode)
(add-hook 'typescript-ts-mode-hook 'copilot-mode)
(add-hook 'json-ts-mode-hook 'copilot-mode)
(add-hook 'java-ts-mode-hook 'copilot-mode)
(add-hook 'tsx-ts-mode-hook 'copilot-mode)
(add-hook 'css-ts-mode-hook 'copilot-mode)
(add-hook 'html-ts-mode-hook 'copilot-mode)

(add-to-list 'copilot-indentation-alist '(python-ts-mode 2))
(add-to-list 'copilot-indentation-alist '(js-ts-mode 2))
(add-to-list 'copilot-indentation-alist '(java-ts-mode 2))
(add-to-list 'copilot-indentation-alist '(tsx-ts-mode 2))
(add-to-list 'copilot-indentation-alist '(html-ts-mode 2))
(add-to-list 'copilot-indentation-alist '(json-ts-mode 2))
(add-to-list 'copilot-indentation-alist '(typescript-ts-mode 2))
(add-to-list 'copilot-indentation-alist '(css-ts-mode 2))

;; 全部补全
(define-key copilot-completion-map (kbd "M-?") 'copilot-accept-completion)
;; 按字接受 Copilot 补全
(define-key copilot-completion-map (kbd "C-<tab>") 'copilot-accept-completion-by-word)

(define-key copilot-completion-map (kbd "M-n") 'copilot-next-completion)
(define-key copilot-completion-map (kbd "M-p") 'copilot-previous-completion)

(custom-set-faces
 '(copilot-overlay-face ((t (:foreground "#d3edcf" :background "#406539" :italic t)))))

(provide 'init-copilot)
