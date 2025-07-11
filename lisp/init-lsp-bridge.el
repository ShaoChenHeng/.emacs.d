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



(add-to-list 'lsp-bridge-multi-lang-server-extension-list '(("html") . "html_tailwindcss"))
(add-to-list 'lsp-bridge-multi-lang-server-extension-list '(("css") . "css_tailwindcss"))

(setq lsp-bridge-lang-server
      '((javascript-mode . "typescript-language-server")
        (typescript-mode . "typescript-language-server")))

(setq lsp-bridge-python-lsp-server "pyright")
(setq lsp-bridge-c-lsp-server "ccls")
(setq lsp-bridge-xml-lsp-server "lemminx")

;;(setq acm-backend-lsp-block-kind-list '("Variable" "Snippet" "Search Word" "Enum"))

(setq lsp-bridge-org-babel-enable t)

(global-lsp-bridge-mode)

(provide 'init-lsp-bridge)
