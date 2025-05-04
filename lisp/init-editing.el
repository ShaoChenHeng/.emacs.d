;; Standard emacs's behavior

;; Enter directly after selecting the text without deleting
(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

;; multi comment
(global-set-key (kbd "C-?") 'comment-or-uncomment-region)

;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; close auto indent
(setq make-backup-files nil)

;; 关闭自己生产的保存文件
(setq auto-save-default nil)

;; yes -> y, no -> n
(fset 'yes-or-no-p 'y-or-n-p)

;; swap 2-indent or 4-indent
(defun my-toggle-web-indent ()
  (interactive)
  ;; web development
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
	(setq js-indent-level (if (= js-indent-level 2) 4 2))
	(setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))

  (if (eq major-mode 'web-mode)
      (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
	     (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
	     (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)p
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))

  (setq indent-tabs-mode nil))


;; 默认搜索当前被选中的或者在光标下的字符串
(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
	    (buffer-substring-no-properties
	     (region-beginning)
	     (region-end))
	  (let ((sym (thing-at-point 'symbol)))
	    (when (stringp sym)
	      (regexp-quote sym))))
	regexp-history)
  (call-interactively 'occur))
(global-set-key (kbd "M-s o") 'occur-dwim)

;; many cursors (just like sublime cursor)
(add-to-list 'load-path "~/.emacs.d/site-lisp/iedit/")
(require 'iedit)
(global-set-key (kbd "M-s e") 'iedit-mode)

;; move code up or dowm
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg)
          (when (and (eval-when-compile
                       '(and (>= emacs-major-version 24)
                             (>= emacs-minor-version 3)))
                     (< arg 0))
            (forward-line -1)))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))


(global-set-key [M-up] 'move-text-up)
(global-set-key [M-down] 'move-text-down)


(add-to-list 'load-path "~/.emacs.d/site-lisp/lazy-load/")
(require 'lazy-load)


;; 向左扩大窗口（通过向右缩小相邻窗口实现）
(defun my/enlarge-window-left ()
  "向左扩大当前窗口宽度"
  (interactive)
  (shrink-window-horizontally -1)) ; 负数表示反向操作

;; 向上扩大窗口（通过向下缩小相邻窗口实现）
(defun my/enlarge-window-up ()
  "向上扩大当前窗口高度"
  (interactive)
  (shrink-window -1)) ; 负数表示反向操作

;; 绑定快捷键
(global-set-key (kbd "M-<left>")  'my/enlarge-window-left)   ; 向左扩大
(global-set-key (kbd "M-<right>") 'enlarge-window-horizontally) ; 向右扩大
(global-set-key (kbd "M-<up>")    'my/enlarge-window-up)     ; 向上扩大
(global-set-key (kbd "M-<down>")  'enlarge-window)           ; 向下扩大

;; 向左缩小窗口（直接调用原生函数）
(defun my/shrink-window-left ()
  "向左缩小当前窗口宽度"
  (interactive)
  (shrink-window-horizontally 1))

;; 向右缩小窗口（需要自定义实现）
(defun my/shrink-window-right ()
  "向右缩小当前窗口宽度"
  (interactive)
  (enlarge-window-horizontally -1)) ; 负数表示反向操作

;; 向上缩小窗口（直接调用原生函数）
(defun my/shrink-window-up ()
  "向上缩小当前窗口高度"
  (interactive)
  (shrink-window 1))

;; 向下缩小窗口（需要自定义实现）
(defun my/shrink-window-down ()
  "向下缩小当前窗口高度"
  (interactive)
  (enlarge-window -1)) ; 负数表示反向操作

;; 绑定缩小快捷键（Control+方向键）
(global-set-key (kbd "C-<left>")  'my/shrink-window-left)   ; 向左缩小
(global-set-key (kbd "C-<right>") 'my/shrink-window-right)  ; 向右缩小
(global-set-key (kbd "C-<up>")    'my/shrink-window-up)     ; 向上缩小
(global-set-key (kbd "C-<down>")  'my/shrink-window-down)   ; 向下缩小

(provide 'init-editing)
