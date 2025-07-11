;; 加载 parrot-mode
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/parrot")
;;(require 'parrot)
;;(parrot-mode 1)

;; config pikachu-mode
(add-to-list 'load-path "~/.emacs.d/site-lisp/pikachu-mode")
(require 'pikachu)
(pikachu-mode 1)

;; config doom-modeline
(require 'doom-modeline)
(setq-default mode-line-format nil)
(doom-modeline-mode 1)

;; pikachu segment
(doom-modeline-def-segment pikachu
  "Display pikachu animation in doom-modeline"
  (when (and (bound-and-true-p pikachu-mode)
             (not (active-minibuffer-window)))
    (propertize " " 'display (pikachu-get-anim-frame))))

(doom-modeline-def-segment window-number
  (when (featurep 'winum)
    (propertize (format " %s " (winum-get-number-string))
                'face '(
			:family "Pokemon Solid"
			:foreground "#f6f6f4"
			:background "#ac86f1"
			:weight bold))))

(setq doom-modeline-minor-mode nil)

;; 创建自定义 modeline
(doom-modeline-def-modeline 'main
  '(window-number pikachu matches buffer-info buffer-position selection-info)
  '(major-mode minor-modes lsp vcs checker misc-info))

;; set modeline font
(setq doom-modeline-height 10)
(if (facep 'mode-line-active)
    (set-face-attribute 'mode-line-active nil :family "mononoki" :height 160) ; For 29+
  (set-face-attribute 'mode-line nil :family "mononoki" :height 160))
(set-face-attribute 'mode-line-inactive nil :family "mononoki" :height 160)

(setq doom-modeline-mode-line 'main)

(doom-modeline-mode 1)

;; pikachu hook
(add-hook 'post-command-hook (lambda () (pikachu-start-animation)))
(add-hook 'emacs-idle-hook (lambda () (pikachu-stop-animation)))

(provide 'init-doom-modeline)
