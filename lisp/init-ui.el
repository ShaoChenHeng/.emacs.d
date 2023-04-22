;; install a theme
;;(use-package gruvbox-theme
;; init(load-theme 'gruvbox-dark-soft t))

;; use monokai
(load-theme 'monokai t) ;; or (load-theme 'monokai-pro t)

;; an elegent mode-line
;;(use-package smart-mode-line
;;  :init
;;  (setq sml/noconfir-load-theme t
;;	sml/theme 'respectful)
;;  (sml/setup))

;; show the line number
(global-linum-mode t)

;; make the background transparent
;; (set-frame-parameter (selected-frame) 'alpha (list 85 60))
;; (add-to-list 'default-frame-alist (cons 'alpha (list 85 60)))
;; (put 'downcase-region 'disabled nil)
(set-frame-parameter nil 'alpha '(85 . 100))

;; hight current line
(use-package hl-line
  :ensure nil
  :hook (after-init . global-hl-line-mode))

;; font
(set-face-attribute 'default nil :height 130)

(defun set-font (english chinese english-size chinese-size)
  (set-face-attribute 'default nil :font
                      ;; (format   "%s:pixelsize=%d"  english english-size) :weight 'semi-bold)
                      (format   "%s:pixelsize=%d"  english english-size) :weight 'bold)

  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset
                      (font-spec :family chinese :size chinese-size :weight 'normal))))


(set-font "Monego" "更纱黑体" 19 19)

;;(set-fontset-font t 'han (font-spec :family "霞鹜文楷" :weight 'bold))
;;(set-fontset-font t 'kana (font-spec :family "Monego" :weight 'bold :slant 'normal))

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

;; highlight when add and remove code
(use-package goggles
  :ensure nil
  :hook ((prog-mode text-mode) . goggles-mode)
  :config
  (setq goggles-pulse-delay 0.06)
  (setq googles-pulse-interations 500)
  (set-face-attribute 'goggles-added nil :background "#74F466")
  (set-face-attribute 'goggles-changed nil :background "#00BBFF")
  (set-face-attribute 'goggles-removed nil :background "#EE365A")
  (setq-default goggles-pulse t) ;; set to nil to disable pulsing
  )

;; doom-modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  (setq doom-modeline-icon t)
  (setq doom-modeline-height 20)
  (defun smaller-modeline ()
    "Make doom-modeline smaller."
    (when window-system
      (create-fontset-from-ascii-font "Source Code Pro:medium" nil "modeline")
      (set-face-attribute 'mode-line nil
                          :height 120 :fontset "fontset-modeline")
      (set-face-attribute 'mode-line-inactive nil
                          :height 120 :fontset "fontset-modeline")))

  (smaller-modeline))

;; make cursor more striking
(require 'beacon)
(beacon-mode 1)
(setq beacon-color "#545c5e")

;; treemacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           20
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)

)
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x b"     . treemacs)
        ("C-x l"     . treemacs-toggle-fixed-width)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))
(require 'treemacs)



;; slim cursor 
(setq-default cursor-type 'bar)

;; pulsing-cursor
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/pulsing-cursor")
;; (require 'pulsing-cursor)
;; (setq-default pulsing-cursor
;;   (set-face-attribute 'pulsing-cursor-overlay-face1 nil :background "#FBF9E2"))



(provide 'init-ui)
