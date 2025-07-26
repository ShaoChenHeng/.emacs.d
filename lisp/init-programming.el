;; treesit-auto
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode)
  )

;; js-ts-mode 缩进设置
;; (add-hook 'js-ts-mode-hook
;;           (lambda ()
;;             (setq-local tab-width 2)
;;             (setq-local js-indent-level 2)))
(add-hook 'js-ts-mode-hook
          (lambda ()
            (setq-local js-indent-level 2)
            (setq-local tab-width 2)))

(add-hook 'java-ts-mode-hook
          (lambda ()
            (setq-local java-ts-mode-indent-offset 2)
	    ))

;; treesit- auto END


(provide 'init-programming)
