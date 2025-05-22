(add-to-list 'load-path "~/.emacs.d/site-lisp/ace-window")
(require 'ace-window)
(setq aw-background t)

(setq aw-ignore-on t)                              ; 新增：确保开启忽略功能
(add-to-list 'aw-ignored-buffers "*sort-tab*")       ; 新增：忽略 sort-tab 缓冲区

(set-face-attribute 'aw-background-face nil
                    :background "grey"       ; 背景色改为红色
                    :foreground "#676863"     ; 字符颜色白色
                    :weight 'bold)

(global-set-key (kbd "C-c C-o") 'ace-window)

(defvar aw-dispatch-alist
  '((?x aw-delete-window "Delete Window")
	(?m aw-swap-window "Swap Windows")
	(?M aw-move-window "Move Window")
	(?c aw-copy-window "Copy Window")
	(?j aw-switch-buffer-in-window "Select Buffer")
	(?n aw-flip-window)
	(?u aw-switch-buffer-other-window "Switch Buffer Other Window")
	(?c aw-split-window-fair "Split Fair Window")
	(?v aw-split-window-vert "Split Vert Window")
	(?b aw-split-window-horz "Split Horz Window")
	(?o delete-other-windows "Delete Other Windows")
	(?? aw-show-dispatch-help))
  "List of actions for `aw-dispatch-default'.")

(provide 'init-ace-window)
