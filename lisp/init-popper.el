(add-to-list 'load-path "~/.emacs.d/site-lisp/popper")
(require 'popper)
(setq popper-reference-buffers
      '("\\*Messages\\*"
        "Output\\*$"
        "\\*Async Shell Command\\*"
	"\\*Occur\\*"
	"\\*Buffer List\\*"
	"\\*Backtrace\\*"
	"\\*Warnings\\*"
	"\\*Python\\*"
	"\\*lsp-bridge-ref\\*"
	"\\*lsp-bridge-diagnostic\\*"
	"\\*color-rg\\*"
        help-mode
        compilation-mode))

(setq popper-ignore-buffers
      '("\\*Treemacs\\*"))

;; =================================================================
;; 拦截 Popper 的 C-`，让它在面对 lazycat 的插件时等效于按下 q
;; =================================================================
(defun my-popper-toggle-lazycat-advice (orig-fun &rest args)
  "拦截 popper-toggle。如果存在 lsp-bridge 或 color-rg 的窗口，则直接调用它们原生的 quit 函数。"
  (let ((lsp-ref-win (get-buffer-window "*lsp-bridge-ref*"))
        (crg-win (get-buffer-window "*color-rg*")))
    (cond
     ;; 如果 lsp-bridge-ref 窗口正在显示，直接调用它的 q (quit) 逻辑
     ((and lsp-ref-win (window-live-p lsp-ref-win))
      (with-selected-window lsp-ref-win
        (call-interactively 'lsp-bridge-ref-quit)))

     ;; 如果 color-rg 窗口正在显示，直接调用它的 q (quit) 逻辑
     ((and crg-win (window-live-p crg-win))
      (with-selected-window crg-win
        (call-interactively 'color-rg-quit)))

     ;; 如果这俩窗口都不在，就正常执行 popper 本身的隐藏/弹出逻辑
     (t
      (apply orig-fun args)))))

;; 挂载拦截器到 popper-toggle 上
(advice-add 'popper-toggle :around #'my-popper-toggle-lazycat-advice)

(global-set-key (kbd "C-`") 'popper-toggle)
(global-set-key (kbd "M-`") 'popper-cycle)
(global-set-key (kbd "C-M-`") 'popper-toggle-type)
(popper-mode +1)

;; For echo-area hints
(require 'popper-echo)
(popper-echo-mode +1)

(provide 'init-popper)
