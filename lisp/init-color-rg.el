;; color-rg 配置
(add-to-list 'load-path "~/.emacs.d/site-lisp/color-rg")
(require 'color-rg)

;; --- 常用功能快捷键配置 ---
;; 我们给全局搜索绑定一个统一的前缀，比如 C-c s (Search)
(global-set-key (kbd "C-c s p") 'color-rg-search-project)               ; 在整个项目内搜索（让你输入搜索词）
(global-set-key (kbd "C-c s s") 'color-rg-search-symbol-in-project)     ; 直接搜索当前光标下的词（极快，无需输入）
(global-set-key (kbd "C-c s d") 'color-rg-search-input-in-current-file) ; 仅在当前文件内搜索
(global-set-key (kbd "C-c s f") 'color-rg-search-input-in-dir)          ; 选择一个特定文件夹进去搜索

;; --- 自动适配主题的完美配色 ---
(with-eval-after-load 'color-rg
  ;; 1. 文件路径：继承「关键字」
  (set-face-attribute 'color-rg-font-lock-file nil
                      :foreground 'unspecified
                      :inherit 'font-lock-keyword-face
                      :weight 'bold)

  ;; 2. 行号：继承「类型」
  (set-face-attribute 'color-rg-font-lock-line-number nil
                      :foreground 'unspecified
                      :inherit 'font-lock-type-face)

  ;; 3. 列号：继承「阴影」
  (set-face-attribute 'color-rg-font-lock-column-number nil
                      :foreground 'unspecified
                      :inherit 'shadow)

  ;; 4. 匹配的高亮代码：继承「字符串」
  (set-face-attribute 'color-rg-font-lock-match nil
                      :foreground 'unspecified
                      :inherit 'font-lock-string-face
                      :weight 'bold)

  ;; 5. 顶部 Header 统计信息
  (set-face-attribute 'color-rg-font-lock-header-line-text nil
                      :foreground 'unspecified
                      :inherit 'font-lock-function-name-face
                      :weight 'bold)

  ;; (color-rg 特有) 顶部搜索关键词的颜色
  (set-face-attribute 'color-rg-font-lock-header-line-keyword nil
                      :foreground 'unspecified
                      :inherit 'warning
                      :weight 'bold)

  ;; (color-rg 特有) 顶部目录路径的颜色
  (set-face-attribute 'color-rg-font-lock-header-line-directory nil
                      :foreground 'unspecified
                      :inherit 'font-lock-keyword-face
                      :weight 'bold)

  ;; 6. 顶部 Header 提示文字 (编辑模式等)
  (set-face-attribute 'color-rg-font-lock-header-line-edit-mode nil
                      :foreground 'unspecified
                      :inherit 'font-lock-constant-face
                      :weight 'bold))

(provide 'init-color-rg)
