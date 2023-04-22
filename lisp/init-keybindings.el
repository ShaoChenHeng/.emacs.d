;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上

(global-set-key (kbd "<f2>") 'open-init-file)

;; swap 2-indent or 4-indent
(global-set-key (kbd "C-c t i") 'my-toggle-web-indent)

;; 默认搜索当前被选中的或者在光标下的字符串
(global-set-key (kbd "M-s o") 'occur-dwim)

;; many cursors (just like sublime cursor)
(global-set-key (kbd "M-s e") 'iedit-mode)

;; move code up or down
(global-set-key [M-up] 'move-text-up)
(global-set-key [M-down] 'move-text-down)

;; restart emacs
(global-set-key (kbd "C-x M-c") 'restart-emacs)

;; quickrun
(use-package quickrun
  :bind
  (("<f5>" . quickrun)
   ("M-<f5>" . quickrun-shell)
   ("C-c e" . quickrun)
   ("C-c C-e" . quickrun-shell)))

;; 标签选择
(lazy-load-global-keys
 '(
   ("M-7" . sort-tab-select-prev-tab)    ;选择前一个标签
   ("M-8" . sort-tab-select-next-tab)    ;选择后一个标签
   ("M-s-7" . sort-tab-select-first-tab) ;选择第一个标签
   ("M-s-8" . sort-tab-select-last-tab)  ;选择最后一个标签
   ("C-;" . sort-tab-close-current-tab)  ;关闭当前标签
   )
 "sort-tab")

(provide 'init-keybindings)
