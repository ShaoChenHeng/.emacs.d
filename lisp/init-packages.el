;;; init-packages.el --- Package management configuration -*- lexical-binding: t -*-

;; ========================================
;; Ⅰ. packages archives setting
;; ========================================
;; (setq package-archives '(("gnu"   . "http://1.15.88.122/gnu/")
;;                          ("melpa" . "http://1.15.88.122/melpa/")))
;; (setq package-archives
;;      '(("gnu"   . "https://elpa.gnu.org/packages/")
;;        ("melpa" . "https://melpa.org/packages/")
;;        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(setq package-archives
      '(("gnu"   . "http://mirrors.cloud.tencent.com/elpa/gnu/")
	("tuna" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/")
	("melpa" . "http://mirrors.cloud.tencent.com/elpa/melpa/")
	("nongnu" . "http://mirrors.cloud.tencent.com/elpa/nongnu/")))

;;(package-initialize) ;; You might already have this line


;; ========================================
;; Ⅱ. package system init
;; ========================================
(setq package-check-signature nil)
(require 'package)
(unless (and (fboundp 'package--initialized) 
             package--initialized)
  (package-initialize))

;; 按需更新包索引（避免每次启动都刷新）
(unless (or (not (file-exists-p (expand-file-name "elpa/archives" user-emacs-directory)))
            package-archive-contents
            (not (network-interface-list)))
  (package-refresh-contents))


;; ========================================
;; Ⅲ. use-package config
;; ========================================
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; use-package
(eval-and-compile
  ;; 基础配置
  (setq use-package-always-ensure t)       ; 自动安装缺失包
  (setq use-package-always-defer nil)      ; 改为按需延迟（重要！）
  (setq use-package-expand-minimally t)    ; 加速启动
  (setq use-package-enable-imenu-support t); 支持imenu索引
  (setq use-package-always-demand nil)     ;按照需加载
  
  ;; 仅调试时启用
  (when init-file-debug
    (setq use-package-verbose t)))


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

(provide 'init-packages)
