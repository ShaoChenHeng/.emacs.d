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

(provide 'init-ui)
