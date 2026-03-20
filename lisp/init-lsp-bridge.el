(setq lsp-bridge-python-command "/home/scheng/.emacs.d/site-lisp/lsp-bridge/.venv/bin/python")
(add-to-list 'load-path "~/.emacs.d/site-lisp/lsp-bridge")

(add-to-list 'load-path "~/.emacs.d/site-lisp/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
(require 'lsp-bridge)
;; minibuffer中启用补全
(setq lsp-bridge-enable-completion-in-minibuffer t)
;;启用语义高亮（Semantic Highlighting），根据语言服务器提供的语义信息高亮代码。
(setq lsp-bridge-semantic-tokens t)


(setq acm-enable-codeium nil)
(setq acm-enable-tabnine nil)
(setq acm-enable-yas nil)
(setq acm-enable-quick-access t)
(setq lsp-bridge-enable-hover-diagnostic t)

;; 定义快捷键切换 Copilot 和 LSP 补全
(global-set-key (kbd "C-c C-c") 'copilot-mode) ;; 开启/关闭 Copilot 补全
(global-set-key (kbd "C-c C-l") 'lsp-bridge-toggle-log) ;; 开启/关闭 LSP 日志


(setq lsp-bridge-python-lsp-server "pyright")
(setq lsp-bridge-c-lsp-server "ccls")
(setq lsp-bridge-xml-lsp-server "lemminx")

;;(setq acm-backend-lsp-block-kind-list '("Variable" "Snippet" "Search Word" "Enum"))

(setq lsp-bridge-org-babel-enable t)

(with-eval-after-load 'lsp-bridge-ref
  ;; 1. 文件路径：继承「关键字」(keyword)
  (set-face-attribute 'lsp-bridge-ref-font-lock-file nil
                      :foreground 'unspecified
                      :inherit 'font-lock-keyword-face
                      :weight 'bold)

  ;; 2. 行号：继承「类型」(type)
  (set-face-attribute 'lsp-bridge-ref-font-lock-line-number nil
                      :foreground 'unspecified
                      :inherit 'font-lock-type-face)

  ;; 3. 列号（行号后面的冒号和数字）：继承「注释」或阴影，弱化显示，减少视觉干扰
  (set-face-attribute 'lsp-bridge-ref-font-lock-column-number nil
                      :foreground 'unspecified
                      :inherit 'shadow)

  ;; 4. 匹配的高亮代码（搜索的关键词）：继承「字符串」(string) 或警告色
  (set-face-attribute 'lsp-bridge-ref-font-lock-match nil
                      :foreground 'unspecified
                      :inherit 'font-lock-string-face
                      :weight 'bold)

  ;; 5. 顶部 Header 统计信息：继承「函数名」(function-name)
  (set-face-attribute 'lsp-bridge-ref-font-lock-header-line-text nil
                      :foreground 'unspecified
                      :inherit 'font-lock-function-name-face
                      :weight 'bold)

  ;; 6. 顶部 Header 提示文字：继承「常量」(constant)
  (set-face-attribute 'lsp-bridge-ref-font-lock-header-line-edit-mode nil
                      :foreground 'unspecified
                      :inherit 'font-lock-constant-face
                      :weight 'bold))

(with-eval-after-load 'lsp-bridge
  ;; 跳转到函数定义
  (define-key lsp-bridge-mode-map (kbd "M-.") 'lsp-bridge-find-def)
  ;; 从函数定义返回
  (define-key lsp-bridge-mode-map (kbd "M-,") 'lsp-bridge-find-def-return)
  ;; 查找引用 (看看这个函数在项目中哪里被调用了)
  (define-key lsp-bridge-mode-map (kbd "M-?") 'lsp-bridge-find-references)
  ;; 变量/函数重命名 (安全重命名，联动修改项目中所有引用的地方)
  (define-key lsp-bridge-mode-map (kbd "C-c r") 'lsp-bridge-rename)
  ;; 查看函数/变量文档 (悬浮窗显示 docstring)
  (define-key lsp-bridge-mode-map (kbd "C-c D") 'lsp-bridge-lookup-documentation)
  ;; 代码格式化 (利用 LSP 格式化当前文件，如 black/clang-format)
  (define-key lsp-bridge-mode-map (kbd "C-c f") 'lsp-bridge-code-format)
  ;; Code Action (快速修复：比如自动导入缺失的包、自动实现接口)
  (define-key lsp-bridge-mode-map (kbd "C-c a") 'lsp-bridge-code-action)
  ;; 重启 LSP 进程 (当增加依赖或 Lsp 卡死时，一键重启，非常实用)
  (define-key lsp-bridge-mode-map (kbd "C-c C-r") 'lsp-bridge-restart-process))
(global-lsp-bridge-mode)

(provide 'init-lsp-bridge)
