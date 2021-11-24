;; Standard emacs's behavior

;; Enter directly after selecting the text without deleting
(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

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


(provide 'init-action)
