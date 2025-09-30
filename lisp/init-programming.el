;; treesit-auto
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

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
            (setq-local java-ts-mode-indent-offset 2)))

(defun my/python-ts-indent-region-or-tab ()
  "在选区时整体缩进，否则插入 TAB 或调用缩进。"
  (interactive)
  (if (use-region-p)
      (indent-region (region-beginning) (region-end))
    (indent-for-tab-command)))

(with-eval-after-load 'python-ts-mode
  (define-key python-ts-mode-map (kbd "TAB") #'my/python-ts-indent-region-or-tab))

;; treesit- auto END

(provide 'init-programming)
