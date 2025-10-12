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

;;; --- python-ts-mode: 选区 Tab 右移 / Shift-Tab 左移 ---
;; 关闭 Python 的缩进猜测，设定全局默认层级为 4
(setq python-indent-guess-indent-offset nil
      python-indent-guess-indent-offset-verbose nil)
(setq-default python-indent-offset 4)

(defun my/python-shift-right (n)
  "选区：每次右移 python-indent-offset*N 列；无选区：按行缩进行为。保持选区。"
  (interactive "p")
  (if (use-region-p)
      (let ((deactivate-mark nil))
        (indent-rigidly (region-beginning) (region-end)
                        (* n (or python-indent-offset tab-width 4))))
    (indent-for-tab-command)))

(defun my/python-shift-left (n)
  "选区：每次左移 python-indent-offset*N 列；无选区：按行缩进行为。保持选区。"
  (interactive "p")
  (if (use-region-p)
      (let ((deactivate-mark nil))
        (indent-rigidly (region-beginning) (region-end)
                        (* -1 n (or python-indent-offset tab-width 4))))
    (indent-for-tab-command)))

(with-eval-after-load 'python
  (add-hook 'python-ts-mode-hook
            (lambda ()
              (setq-local indent-tabs-mode nil
                          tab-width 4)
              (define-key python-ts-mode-map (kbd "<tab>")     #'my/python-shift-right)
              (define-key python-ts-mode-map (kbd "<backtab>") #'my/python-shift-left)
              (define-key python-ts-mode-map (kbd "S-<tab>")   #'my/python-shift-left))))

;; treesit- auto END

(provide 'init-programming)
