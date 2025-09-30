;; use monokai
(add-to-list 'load-path "~/.emacs.d/site-lisp/monokai-emacs")
(require 'monokai-theme)
(setq  monokai-comments "#7A8599")
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-color-theme-solarized")
(require 'solarized-theme)

;; 你自己的主题搭配（白天/夜间）
;;(defvar my/day-theme 'gruvbox)
(defvar my/day-theme 'solarized)
(defvar my/night-theme 'monokai)

(defvar my/daytime-start "07:00")
(defvar my/nighttime-start "19:00")

(defun my/apply-theme (theme)
  "禁用当前已启用主题，加载指定 THEME。"
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme t))

(defun my/apply-theme-now-based-on-time ()
  "根据当前时间立即切换主题。"
  (let* ((now (string-to-number (format-time-string "%H%M")))
         (day-start (string-to-number (replace-regexp-in-string ":" "" my/daytime-start)))
         (night-start (string-to-number (replace-regexp-in-string ":" "" my/nighttime-start))))
    (if (and (>= now day-start) (< now night-start))
        (my/apply-theme my/day-theme)
      (my/apply-theme my/night-theme))))

;; 启动时先选一次
(my/apply-theme-now-based-on-time)

;; 每天在指定时间切换
(run-at-time my/daytime-start (* 24 60 60) (lambda () (my/apply-theme my/day-theme)))
(run-at-time my/nighttime-start (* 24 60 60) (lambda () (my/apply-theme my/night-theme)))

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
                      :height 150)       ; vfont size

  ;; 设置中文字体（覆盖CJK字符集）
  (dolist (charset '(kana han cjk-misc bopomofo))
    (set-fontset-font t charset
                      (font-spec :family "LXGW WenKai"   ; 霞鹜文楷
                                 :size 21))))            ; 中文字号
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
(pixel-scroll-precision-mode t)

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
	  )))
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
;; no voice
;; 完全禁用声音
(setq ring-bell-function 'ignore)

;; ident-bars
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/indent-bars")
;; (require 'indent-bars)
;; (setq indent-bars-width-frac 0.15)
;; (add-hook 'prog-mode-hook 'indent-bars-mode)

(provide 'init-ui)
