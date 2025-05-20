
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
        help-mode
        compilation-mode))

(setq popper-ignore-buffers
      '("\\*Treemacs\\*"  ; 直接匹配 Treemacs 缓冲区名

        ))

(global-set-key (kbd "C-`") 'popper-toggle)
(global-set-key (kbd "M-`") 'popper-cycle)
(global-set-key (kbd "C-M-`") 'popper-toggle-type)
(popper-mode +1)

;; For echo-area hints
(require 'popper-echo)
(popper-echo-mode +1)

(provide 'init-popper)
