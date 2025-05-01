(use-package transient
  :ensure t
  :config
  (setq transient-history-file "~/.emacs.d/transient/history.el"))


(global-set-key (kbd "C-c f") 'my-file-menu)

(setq transient-mode-line-format '(" %b "))  ; 隐藏模式行提示
(setq transient-enable-popup-navigation t)   ; 允许鼠标操作

(provide 'init-transient)
