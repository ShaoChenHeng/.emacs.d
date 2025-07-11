;; treesit-auto
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode)
  )

;; js-ts-mode 缩进设置
(add-hook 'js-ts-mode-hook
          (lambda ()
            (setq-local tab-width 2)
            (setq-local js-indent-level 2)))

(provide 'init-programming)
