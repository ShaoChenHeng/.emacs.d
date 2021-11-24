;; close tool-bar
;; close scroll-bar
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

(setq gc-cons-threshold most-positive-fixnum)

;; close startup-screen
(setq inhibit-startup-screen t)

;; 括号配对
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; scheme 语法高亮
;; (require 'parentesis)

;; Load Private File
;; Load init-private.el if it exists
;; (when (file-exists-p (expand-file-name "init-private.el" user-emacs-directory))
;;  (load-file (expand-file-name "init-private.el" user-emacs-directory)))

(provide 'init-startup)
