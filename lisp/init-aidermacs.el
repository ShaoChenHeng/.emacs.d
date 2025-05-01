(add-to-list 'load-path "~/.emacs.d/site-lisp/aidermacs")
(require 'aidermacs)

(global-set-key (kbd "C-c a") 'aidermacs-transient-menu)
;; (add-hook 'aidermacs-before-run-backend-hook
;;           (lambda ()
;;             (setenv "DEEPSEEK_API_KEY" (getenv "ANTHROPIC_API_KEY_FROM_ENV"))))
(setenv "DEEPSEEK_API_KEY" (getenv "DEEPSEEK_API_KEY_FROM_ENV"))
(setq aidermacs-backend 'comint)
(setq aidermacs-use-architect-mode t)
(setq aidermacs-comint-multiline-newline-key "S-<return>")
(setq aidermacs-default-model "deepseek")

;; Optional: Set specific model for architect reasoning
(setq aidermacs-architect-model "deepseek/deepseek-reasoner")

;; Optional: Set specific model for code generation
(setq aidermacs-editor-model "deepseek/deepseek-chat")



(provide 'init-aidermacs)
