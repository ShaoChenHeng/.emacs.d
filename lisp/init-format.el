(use-package format-all
  :commands format-all-mode
  ;;:hook (prog-mode . format-all-mode)
  :config
  (setq-default format-all-formatters
                '(("C"     (astyle "--mode=c"
				   "--indent=spaces=2"
				   ))
		  ("Python" (black "-q"

				   ))
		  ("Java" (clang-format "-style=Google"))
                  ("Shell" (shfmt "-i"
				  "4"
				  "-ci")))))

(global-set-key (kbd "C-c f") 'format-all-buffer)

(add-hook 'java-mode-hook
          (lambda ()
            ;; 基础缩进设置
            (setq-local c-basic-offset 2    ; 2空格缩进
                        tab-width 2         ; 制表符宽度
                        indent-tabs-mode nil) ; 强制使用空格

            ;; 针对 lsp-bridge 的适配
            (when (boundp 'lsp-bridge-mode)
              (setq-local lsp-bridge-indent-width 2))))

(provide 'init-format)
