;; Magit 基础配置
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)         ; 快捷键打开 magit-status
         ("C-x M-g" . magit-dispatch))
  
  :config

  ;; 增强功能
;;  (magit-diff-refine-hunk t)         ; 显示更精细的 diff 高亮
;;  (magit-revision-show-gravatars t)  ; 显示 gravatar 头像（如果有）
  )

(provide 'init-magit)
