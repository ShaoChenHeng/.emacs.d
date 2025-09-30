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

;;(setq lsp-bridge-python-command "")
(defun my/lsp-bridge-auto-set-python-command ()
  "为每个项目自动设置 lsp-bridge-python-command，指向项目根下的 .venv/bin/python 或 venv/bin/python。"
  (when (derived-mode-p 'python-ts-mode)
    (let* ((project-root
            (or
             (when (fboundp 'project-root)
               (project-root (project-current)))
             (when (fboundp 'projectile-project-root)
               (projectile-project-root))
             (locate-dominating-file default-directory ".git")))
           (python-path
            (cl-loop for venv in '(".venv/bin/python" "venv/bin/python" "env/bin/python")
                     for full-path = (and project-root (expand-file-name venv project-root))
                     when (and full-path (file-executable-p full-path))
                     return full-path)))
      (when python-path
        (setq-local lsp-bridge-python-command python-path)
        (message "lsp-bridge-python-command set to: %s" python-path)))))

(add-hook 'python-ts-mode-hook #'my/lsp-bridge-auto-set-python-command)
(with-eval-after-load 'lsp-bridge
  (define-key lsp-bridge-mode-map (kbd "M-.") 'lsp-bridge-find-def)
  (define-key lsp-bridge-mode-map (kbd "M-,") 'lsp-bridge-find-def-return))
(global-lsp-bridge-mode)

(provide 'init-lsp-bridge)
