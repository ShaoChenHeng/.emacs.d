;; use monokai
(add-to-list 'load-path "~/.emacs.d/site-lisp/monokai-emacs")
(require 'monokai-theme)
;;(with-eval-after-load 'monokai-theme
;;  (set-face-attribute 'highlight nil :distant-foreground 'unspecified))
(load-theme 'monokai t) ;; or (load-theme 'monokai-pro t)

;; close tool-bar
;; close scroll-bar
;; close menu-bar
;; close startup-screen
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-screen t)

;; show the line number
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
;;(global-display-line-numbers-mode 1)

;; slim cursor 
(setq-default cursor-type 'bar)

;; hight current line
(use-package hl-line
  :ensure nil
  :hook (after-init . global-hl-line-mode))

;; font
(when (display-graphic-p)  ; only gui
  ;; English font (Mono prefer)
  (set-face-attribute 'default nil
                      :family "monego"   ; font name
                      :weight 'regular   ; regular or bold
                      :height 180)       ; font size

  ;; 设置中文字体（覆盖CJK字符集）
  (dolist (charset '(kana han cjk-misc bopomofo))
    (set-fontset-font t charset
                      (font-spec :family "LXGW WenKai"   ; 霞鹜文楷
                                 :size 23))))            ; 中文字号

;; highlight org-mode
(require 'org)
(setq org-src-fontify-natively t)

;; highlight two brackets when cursor in code
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     (funcall fn)))))

;; inverse color when the area selected
(defun my/region-highlight-if-whole-line ()
  "if the line selected inverse color"
  (when (and (region-active-p)
             (save-excursion
               (let ((beg (region-beginning))
                     (end (region-end)))
                 (and (<= (line-beginning-position) beg)
                      (>= (line-end-position) end)))))
    (face-remap-add-relative 'region '(:inverse-video t))))

(add-hook 'activate-mark-hook #'my/region-highlight-if-whole-line)

;; Smooth Scrolling
;; Vertical Scroll
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
(setq scroll-step 1)
(setq scroll-margin 1)
(setq scroll-conservatively 101)
(setq scroll-up-aggressively 0.01)
(setq scroll-down-aggressively 0.01)
(setq auto-window-vscroll nil)
(setq fast-but-imprecise-scrolling nil)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)

;; Horizontal Scroll
(setq hscroll-step 1)
(setq hscroll-margin 1)

;;(setq-default truncate-lines t) 

;; pretty symbols
(global-prettify-symbols-mode 1)
(defun add-pretty-lambda ()
  "Make some word or string show as pretty Unicode symbols.
   See https://unicodelookup.com for more."
  (setq prettify-symbols-alist
        '(("lambda" . 955)
          ("delta" . 120517)
          ("epsilon" . 120518)
          ("->" . 8594)
          ("<=" . 8804)
          (">=" . 8805))))
(add-hook 'prog-mode-hook 'add-pretty-lambda)
(add-hook 'org-mode-hook 'add-pretty-lambda)

;;highlight when add or remove code
(use-package goggles
  :hook ((prog-mode text-mode) . goggles-mode)
  :init
  (setq goggles-pulse t)
  :config
  (setq goggles-pulse-delay 0.06)
  (setq googles-pulse-iterations 500)
  (set-face-attribute 'goggles-added nil :background "#74F466")
  (set-face-attribute 'goggles-changed nil :background "#00BBFF")
  (set-face-attribute 'goggles-removed nil :background "#EE365A")
  (setq-default goggles-pulse t) ;; set to nil to disable pulsing
  )

;; smooth scroll
(pixel-scroll-precision-mode t)

;; no voice
;; 完全禁用声音
(setq ring-bell-function 'ignore)

;; colorful dired
(add-to-list 'load-path "~/.emacs.d/site-lisp/diredfl")
(require 'diredfl)
(diredfl-global-mode 1)

;; show icons in dired
(add-to-list 'load-path "~/.emacs.d/site-lisp/all-the-icons-dired")
(load "all-the-icons-dired.el")
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; hide or show .xxxx files in dired
(add-to-list 'load-path "~/.emacs.d/site-lisp/dired-hide-dotfiles")
(load "dired-hide-dotfiles")
(dired-hide-dotfiles-mode 1)
(defun my-dired-mode-hook ()
  "My `dired' mode hook."
  ;; To hide dot-files by default
  (dired-hide-dotfiles-mode))
(define-key dired-mode-map "." #'dired-hide-dotfiles-mode)
(add-hook 'dired-mode-hook #'my-dired-mode-hook)


(provide 'init-ui)
