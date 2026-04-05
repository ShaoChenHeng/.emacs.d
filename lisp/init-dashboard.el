;;; init-dashboard.el --- Dashboard configuration -*- lexical-binding: t -*-

;; 启用并配置 all-the-icons
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p)
  :config
  ;; 如果没有安装字体，自动安装
  (unless (find-font (font-spec :name "all-the-icons"))
    (all-the-icons-install-fonts)))

;; 统一行号设置
(unless (fboundp 'linum-mode)
  (defalias 'linum-mode 'display-line-numbers-mode))

;; 启用 Dashboard
(use-package dashboard
  :ensure t
  :init
  (setq dashboard-icon-type 'all-the-icons)

  :custom
  (dashboard-center-content t)
  (dashboard-banner-logo-title "Hello  World !")
  (initial-buffer-choice (lambda () (get-buffer dashboard-buffer-name)))

  ;; 启用 Dashboard 图标
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t)
  (dashboard-set-navigator t)

  (dashboard-items '((recents   . 10)
                     (bookmarks . 5)
                     (projects  . 5)))

  ;; 单独使用 :custom-face 来定义样式
  :custom-face
  (dashboard-banner-logo-title ((t (:family "eva" :height 1.9 :weight regular))))

  :config
  ;; 修改标题图标
  (dashboard-modify-heading-icons '((recents   . "file-text")
                                    (bookmarks . "book")))

  ;; 官方推荐的启动方式
  (dashboard-setup-startup-hook)

  ;; 关闭 dashboard 里的行号显示
  (add-hook 'dashboard-mode-hook (lambda ()
                                   (display-line-numbers-mode -1)))

  ;; 设置自定义快捷按钮
  (setq dashboard-navigator-buttons
        (if (featurep 'all-the-icons)
            `(((,(all-the-icons-octicon "mark-github" :height 1.1 :v-adjust -0.05)
                "My Emacs" "Browse My EMACS Homepage"
                (lambda (&rest _) (browse-url "https://github.com/shaochenheng/.emacs.d")))
               (,(all-the-icons-fileicon "elisp" :height 1.0 :v-adjust -0.1)
                "Configuration" "" (lambda (&rest _) (edit-configs)))
               (,(all-the-icons-faicon "cogs" :height 1.0 :v-adjust -0.1)
                "Update" "" (lambda (&rest _) (auto-package-update-now)))))
          `((("" "My Emacs" "" (lambda (&rest _) (browse-url "https://github.com/shaochenheng/.emacs.d")))
             ("" "Configuration" "" (lambda (&rest _) (edit-configs)))
             ("" "Update" "" (lambda (&rest _) (auto-package-update-now))))))))

;; 设定 Dashboard 显示顺序
(setq dashboard-startupify-list '(dashboard-insert-banner
                                  dashboard-insert-newline
                                  dashboard-insert-banner-title
                                  dashboard-insert-newline
                                  dashboard-insert-navigator
                                  dashboard-insert-newline
                                  dashboard-insert-init-info
                                  dashboard-insert-items
                                  dashboard-insert-newline
                                  dashboard-insert-footer))

;; 随机背景图逻辑
(let ((time-sec (caddr (current-time))))
  (if (= (% time-sec 2) 0)
      (setq dashboard-startup-banner
            (concat "~/.emacs.d/dashboardPic/pic/p"
                    (number-to-string (+ (% time-sec 23) 1))
                    ".png"))
    (setq dashboard-startup-banner
          (concat "~/.emacs.d/dashboardPic/gif/"
                  (number-to-string (+ (% time-sec 19) 1))
                  ".gif"))))

;; 如果是终端环境，禁用图标
(unless (display-graphic-p)
  (setq dashboard-set-file-icons nil)
  (setq dashboard-set-heading-icons nil))

(provide 'init-dashboard)
