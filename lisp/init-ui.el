;; install a theme
;;(use-package gruvbox-theme
;; init(load-theme 'gruvbox-dark-soft t))

;; use monokai
(load-theme 'monokai-pro t) ;; or (load-theme 'monokai-pro t)

;; an elegent mode-line
(use-package smart-mode-line
  :init
  (setq sml/noconfir-load-theme t
	sml/theme 'respectful)
  (sml/setup))

;; show the line number
(global-linum-mode t)

;; make the background transparent
;; (set-frame-parameter (selected-frame) 'alpha (list 85 60))
;; (add-to-list 'default-frame-alist (cons 'alpha (list 85 60)))
;; (put 'downcase-region 'disabled nil)

;; hight current line
(use-package hl-line
  :ensure nil
  :hook (after-init . global-hl-line-mode))

;; font
(set-face-attribute 'default nil :height 100)

(defun set-font (english chinese english-size chinese-size)
  (set-face-attribute 'default nil :font
                      ;; (format   "%s:pixelsize=%d"  english english-size) :weight 'semi-bold)
                      (format   "%s:pixelsize=%d"  english english-size))

  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset
                      (font-spec :family chinese :size chinese-size :weight 'medium))))

(set-font "Hack" "Hack" 20 20)

;; slim cursor
(setq-default cursor-type 'bar)

;; highlight org-mode
(require 'org)
(setq org-src-fontify-natively t)

;; selected region color
(custom-set-faces
  '(region ((t (:inhert (highlight default) :extend t :background "RoyalBlue1")))))

;; highlight two brackets when cursor in code
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     (funcall fn)))))

;; Smooth Scrolling
;; Vertical Scroll
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

;; Title Bar
(setq-default frame-title-format '("EMACS - " user-login-name "@" system-name " - %b"))

;; Modeline Time and Battery
(display-time-mode 1)
(display-battery-mode 1)

;; pretty symbols
(global-prettify-symbols-mode 1)
(defun add-pretty-lambda ()
  "Make some word or string show as pretty Unicode symbols.  See https://unicodelookup.com for more."
  (setq prettify-symbols-alist
        '(("lambda" . 955)
          ("delta" . 120517)
          ("epsilon" . 120518)
          ("->" . 8594)
          ("<=" . 8804)
          (">=" . 8805))))
(add-hook 'prog-mode-hook 'add-pretty-lambda)
(add-hook 'org-mode-hook 'add-pretty-lambda)


(provide 'init-ui)
