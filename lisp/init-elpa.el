;; add tinghua resource
(setq package-archives '(("gnu"   . "http://mirrors.cloud.tencent.com/elpa/gnu/")
                         ("melpa" . "http://mirrors.cloud.tencent.com/elpa/melpa/")
                         ;;("melpa" . "https://melpa.org/packages/")
                         ("cselpa" . "https://elpa.thecybershadow.net/packages/")))

(package-initialize) ;; You might already have this line

;; package initialize
(setq package-check-signature nil)

(require 'package)

(unless (bound-and-true-p package--initialized)
  (package-initialize))

;; refresh resource
(unless package-archive-contents
  (package-refresh-contents))

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; use-package

(eval-and-compile
  (setq use-package-always-ensure t)    ; 不用每个包都手动添加:ensure t 关键字
  (setq use-package-always-defer t)     ; 默认都是延时加载，不用每个包都手动添加:defer t 关键字
  (setq use-package-always-demand nil)  ;
  (setq use-package-expand-minimally t) ;
  (setq use-package-verbose t)          ; 打印安装过程
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" default)))
 '(package-selected-packages
   (quote
    (smart-mode-line monokai-theme restart-emacs use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'init-elpa)
