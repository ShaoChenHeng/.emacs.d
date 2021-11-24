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
(set-frame-parameter (selected-frame) 'alpha (list 85 60))
(add-to-list 'default-frame-alist (cons 'alpha (list 85 60)))
(put 'downcase-region 'disabled nil)

;; hight current line
(use-package hl-line
  :ensure nil
  :hook (after-init . global-hl-line-mode))

;; font
(set-face-attribute 'default nil :height 100)

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

(provide 'init-ui)
