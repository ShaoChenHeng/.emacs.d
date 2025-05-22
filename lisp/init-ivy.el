(use-package ivy
  :defer 1
  :demand
  :hook (after-init . ivy-mode)
  :config

  (define-key ivy-minibuffer-map (kbd "TAB") #'ivy-partial)
  ;; 回车直接确认选择
  (define-key ivy-minibuffer-map (kbd "<return>") #'ivy-done)

  ;; 反色选中项
  (set-face-attribute 'ivy-current-match nil
                      :inverse-video t
                      :weight 'bold)
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-height 10)
  (ivy-on-del-error-function nil)
  (ivy-magic-slash-non-match-action 'ivy-magic-slash-non-match-create)
  (ivy-count-format "【%d/%d】")
  (ivy-wrap t))


(use-package counsel
  :ensure t
  :after ivy
  :bind (("M-x" . counsel-M-x)          ; 增强版M-x
         ("C-x b" . counsel-switch-buffer) ; 增强版缓冲区切换
         ("C-c g" . counsel-git)        ; Git文件搜索
         ("C-c j" . counsel-git-grep)   ; Git内容搜索
         ("C-c k" . counsel-ag)         ; ag搜索
         ("C-x l" . counsel-locate))    ; 系统文件搜索
  :config
  (setq counsel-mode-override-describe-bindings nil))

(use-package swiper
  :ensure t
  :after ivy
  :bind (("C-s" . swiper)               ; 增强版isearch
         ("C-r" . swiper-backward)))    ; 反向搜索

(defun my-find-file()
  (interactive)
  (ivy-mode -1)
  (call-interactively 'find-file)
  (ivy-mode 1))
(global-set-key (kbd "C-x C-f") 'my-find-file)

(provide 'init-ivy)
