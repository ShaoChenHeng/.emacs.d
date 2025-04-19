;; use all-the-icons
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p)  ; 仅在图形界面启用
  :config
  (unless (find-font (font-spec :name "all-the-icons"))
    (all-the-icons-install-fonts))); 自动安装字体  
(unless (fboundp 'linum-mode)
  (defalias 'linum-mode 'display-line-numbers-mode))
;; 启用 Dashboard
(use-package dashboard
  :ensure t
  :config
  (add-hook 'elpaca-after-init-hook #'dashboard-insert-startupify-lists)
  (add-hook 'elpaca-after-init-hook #'dashboard-initialize)
  (dashboard-setup-startup-hook); 设置 Dashboard 为启动画面
  (add-hook 'dashboard-mode-hook (lambda () 
                                   (display-line-numbers-mode -1)))
  :custom
  (dashboard-center-content t)
  (dashboard-banner-logo-title "Hello  World !")
  (initial-buffer-choice (lambda () (get-buffer dashboard-buffer-name)))

  ;; 启用 Dashboard 图标
  (dashboard-set-heading-icons t)  ; 标题图标
  (dashboard-set-file-icons t)     ; 文件图标
  (dashboard-set-navigator t)      ; 底部导航栏
  (dashboard-items '((recents   . 10)  ; 显示最近 10 个文件
                          (bookmarks . 5)   ; 显示 5 个书签
                          (projects  . 5))) ; 显示 5 个项目

  ;; set .emacs.d github button
  (dashboard-navigator-buttons
	(if (featurep 'all-the-icons)
	    `(((,(all-the-icons-octicon "mark-github" :height 1.1 :v-adjust -0.05)
		"My Emacs"
		 "Browse My EMACS Homepage"
		(lambda (&rest _) (browse-url "https://github.com/shaochenheng/.emacs.d")))
               (,(all-the-icons-fileicon "elisp" :height 1.0 :v-adjust -0.1)
		"Configuration"
		"" (lambda (&rest _) (edit-configs)))
               (,(all-the-icons-faicon "cogs" :height 1.0 :v-adjust -0.1)
		"Update" "" (lambda (&rest _) (auto-package-update-now)))))
	  `((("" "My Emacs"
              (lambda (&rest _) (browse-url "https://github.com/shaochenheng/.emacs.d")))
             ("" "Configuration" "" (lambda (&rest _) (edit-configs)))
             ("" "Update" "" (lambda (&rest _) (auto-package-update-now)))))))

  :custom-face

  (dashboard-banner-logo-title ((t (:family "eva"
					    :height 1.9
					    :weight regular))))


)

(dashboard-modify-heading-icons '((recents   . "file-text")
                                  (bookmarks . "book")))

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

;; Set the banner
;; Value can be
;; 'official which displays the official emacs logo
;; 'logo which displays an alternative emacs logo
;; 1, 2 or 3 which displays one of the text banners
;; "path/to/your/image.gif", "path/to/your/image.png" or "path/to/your/text.txt" which displays whatever gif/image/text you would prefer

(setq dashboard-startup-banner
      (concat "/home/scheng/.emacs.d/dashboardPic/pic/p"
	      (number-to-string (+ (% (caddr (current-time)) 23) 1))
	      ".png"))
 
 
(if (= (% (caddr (current-time)) 2) 0)
    (setq dashboard-startup-banner
          (concat "/home/scheng/.emacs.d/dashboardPic/pic/p"
	                (number-to-string (+ (% (caddr (current-time)) 23) 1))
	                ".png"))
  (setq dashboard-startup-banner
        (concat "/home/scheng/.emacs.d/dashboardPic/gif/"
	              (number-to-string (+ (% (caddr (current-time)) 19) 1))
	              ".gif")))

;; 如果是终端环境，禁用图标
(unless (display-graphic-p)
  (setq dashboard-set-file-icons nil)
  (setq dashboard-set-heading-icons nil))



(provide 'init-dashboard)
