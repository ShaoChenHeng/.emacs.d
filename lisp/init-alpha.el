;;;;;;;;;;;;;;;;;;;
;; MUST LAST LOAD
;;;;;;;;;;;;;;;;;;;

;; make the background transparent
;;(set-frame-parameter nil 'alpha '(80 . 100))
;;(set-frame-parameter (selected-frame) 'alpha-background 75)  ; 背景透明度 80%
;;(set-frame-parameter (selected-frame) 'alpha-foreground 100) ; 文字不透明 100%

;; 定义 dashboard 专用的 alpha-background 值
(defvar my-dashboard-alpha-bg 15)
;; 原主题的当前行高亮在透明dashboard中可见度太低，重新设置
(defvar my-dashboard-hl-line-bg "#5a94f5")
;; 定义其他缓冲区的默认 alpha-background 值
(defvar my-default-alpha-bg 75)

(defun my-update-alpha-background()
  (let ((current-buffer (buffer-name)))
    (if (string= current-buffer "*dashboard*")
	(progn
          (set-frame-parameter (selected-frame) 'alpha-background my-dashboard-alpha-bg)
	  (face-remap-add-relative
	   'hl-line
	   `(:background ,my-dashboard-hl-line-bg)))
      (set-frame-parameter (selected-frame) 'alpha-background my-default-alpha-bg)
	)))

;; 添加自动检测钩子
(add-hook 'post-command-hook #'my-update-alpha-background)

;; 确保后续创建的窗口也继承设置
(setq default-frame-alist initial-frame-alist)

(provide 'init-alpha)
