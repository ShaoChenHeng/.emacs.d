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

(provide 'init-keybindings)
