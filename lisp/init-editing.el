(setq gc-cons-threshold (* 100 1024 1024))

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

;; iedit (配合narrow-region 使用效果更佳)
;;
;; M-x narrow-to-region（默认绑定到 C-x n n）
;; 此时缓冲区只显示选中部分，其他内容被隐藏。
;;
;;执行 M-x widen（默认绑定到 C-x n w）
;;缓冲区恢复显示全部内容
(add-to-list 'load-path "~/.emacs.d/site-lisp/iedit/")
(require 'iedit)
(global-set-key (kbd "M-s e") 'iedit-mode)

;; move text up or down
(add-to-list 'load-path "~/.emacs.d/site-lisp/move-text/")
(require 'move-text)
(global-set-key (kbd "C-<up>") 'move-text-up)
(global-set-key (kbd "C-<down>") 'move-text-down)

;; open new line above or below
(add-to-list 'load-path "~/.emacs.d/site-lisp/open-newline/")
(require 'open-newline)
(global-set-key (kbd "C-<return>") 'open-newline-above)
(global-set-key (kbd "M-<return>") 'open-newline-below)

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

;; 智能复制：有选区复制选区，无选区复制整行
(defun smart-copy ()
  "Copy region if active, otherwise copy current line."
  (interactive)
  (if (use-region-p)
      (kill-ring-save (region-beginning) (region-end))
    (save-excursion
      (kill-ring-save (line-beginning-position) (line-end-position))
    (message "Copied line"))))

(global-set-key (kbd "M-w") 'smart-copy)

;; 启用 watch-other-window 并绑定快捷键：
;; C--/C-= 翻页，M--/M-= 行滚动（需先分屏）
(add-to-list 'load-path "~/.emacs.d/site-lisp/watch-other-window")
(require 'watch-other-window)
(global-set-key (kbd "C--")  'watch-other-window-down)
(global-set-key (kbd "C-=")  'watch-other-window-up)
(global-set-key (kbd "M--")  'watch-other-window-down-line)
(global-set-key (kbd "M-=")  'watch-other-window-up-line)

;; auto save
(add-to-list 'load-path "~/.emacs.d/site-lisp/auto-save")
(require 'auto-save)
(auto-save-enable)

(setq auto-save-silent t)   ; quietly save
(setq auto-save-delete-trailing-whitespace t)  ; automatically delete spaces at the end of the line when saving

;;; custom predicates if you don't want auto save.
;;; disable auto save mode when current filetype is an gpg file.
(setq auto-save-disable-predicates
      '((lambda ()
      (string-suffix-p
      "gpg"
      (file-name-extension (buffer-name)) t))))



(add-to-list 'load-path "~/.emacs.d/site-lisp/goto-line-preview")
(require 'goto-line-preview)
(global-set-key (kbd "M-g M-g")  'goto-line-preview)
;; Highlight 1.5 seconds when change preview line
(setq goto-line-preview-hl-duration 1.5)

;; expand-region
;; use C-= select the whole word
(require 'expand-region)
(global-set-key (kbd "M-r") 'er/expand-region)

;; Change highlight background color to white
(set-face-background 'goto-line-preview-hl "#5a94f5")

;; 快速eval-buffer
(global-set-key (kbd "C-c C-e") 'eval-buffer)

;; 快速重启
(global-set-key (kbd "C-c C-r") 'restart-emacs)

;;快速打开*Message*
(global-set-key (kbd "C-c m") 'view-echo-area-messages)

;; 快速执行python
;; 当前配置有点奇怪，C-c C-c会执行python程序，还需要C-c C-p打开（终端）才能看到结果
(global-set-key (kbd "C-c C-p") 'run-python)

;; 和输入法启动冲突，所以禁止
(global-unset-key (kbd "M-/"))

(provide 'init-editing)
