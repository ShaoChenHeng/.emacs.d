;; YASnippet, a programming template system for Emacs. It loads YASnippet Snippets, a collection of yasnippet snippets for many languages.
(add-to-list 'load-path
             "~/.emacs.d/site-lisp/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; Flycheck, a syntax checking extension.
(use-package flycheck
  :defer t
  :diminish
  :hook (after-init . global-flycheck-mode)
  :commands (flycheck-add-mode)
  :custom
  (flycheck-global-modes
   '(not outline-mode diff-mode shell-mode eshell-mode term-mode))
  (flycheck-emacs-lisp-load-path 'inherit)
  (flycheck-indication-mode (if (display-graphic-p) 'right-fringe 'right-margin))
  :init
  (if (display-graphic-p)
      (use-package flycheck-posframe
        :custom-face
        (flycheck-posframe-face ((t (:foreground ,(face-foreground 'success)))))
        (flycheck-posframe-info-face ((t (:foreground ,(face-foreground 'success)))))
        :hook (flycheck-mode . flycheck-posframe-mode)
        :custom
        (flycheck-posframe-position 'window-bottom-left-corner)
        (flycheck-posframe-border-width 3)
        (flycheck-posframe-inhibit-functions
         '((lambda (&rest _) (bound-and-true-p company-backend)))))
    (use-package flycheck-pos-tip
      :defines flycheck-pos-tip-timeout
      :hook (flycheck-mode . flycheck-pos-tip-mode)
      :custom (flycheck-pos-tip-timeout 30)))
  :config
  (use-package flycheck-popup-tip
    :hook (flycheck-mode . flycheck-popup-tip-mode))
  (when (fboundp 'define-fringe-bitmap)
    (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
      [16 48 112 240 112 48 16] nil nil 'center))
  (when (executable-find "vale")
    (use-package flycheck-vale
      :config
      (flycheck-vale-setup)
      (flycheck-add-mode 'vale 'latex-mode))))

;; Flyspell enables on-the-fly spell checking in Emacs and uses Flyspell Correct for distraction-free words correction using Ivy.
(use-package flyspell
  :ensure nil
  :diminish
  :if (executable-find "aspell")
  :hook (((text-mode outline-mode latex-mode org-mode markdown-mode) . flyspell-mode))
  :custom
  (flyspell-issue-message-flag nil)
  (ispell-program-name "aspell")
  (ispell-extra-args
   '("--sug-mode=ultra" "--lang=en_US" "--camel-case"))
  :config
  (use-package flyspell-correct-ivy
    :after ivy
    :bind
    (:map flyspell-mode-map
          ([remap flyspell-correct-word-before-point] . flyspell-correct-wrapper)
          ("C-." . flyspell-correct-wrapper))
    :custom (flyspell-correct-interface #'flyspell-correct-ivy)))

;; quick run
(use-package quickrun
  :bind
  (("<f5>" . quickrun)
   ("M-<f5>" . quickrun-shell)
   ("C-c e" . quickrun)
   ("C-c C-e" . quickrun-shell)))

;; lsp java
;; LSP Java, Emacs Java IDE using Eclipse JDT Language Server. Note that this package is dependant on Request.
(use-package lsp-java
  :after lsp-mode
  :if (executable-find "mvn")
  :init
  (use-package request :defer t)
  :custom
  (lsp-java-server-install-dir (expand-file-name "~/.emacs.d/eclipse.jdt.ls/server/"))
  (lsp-java-workspace-dir (expand-file-name "~/.emacs.d/eclipse.jdt.ls/workspace/")))

;; Python Configuration

(use-package python-mode
  :ensure nil
  :after flycheck
  :mode "\\.py\\'"
  :custom
  (python-indent-offset 4)
  (flycheck-python-pycompile-executable "python3")
  (python-shell-interpreter "python3"))

;; LSP Pyright
;; LSP Pyright, a lsp-mode client leveraging Pyright language server.

(use-package lsp-pyright
  :hook (python-mode . (lambda () (require 'lsp-pyright)))
  :custom
  (lsp-pyright-multi-root nil))

;; js2-mode
(use-package js2-mode
  :mode "\\.js\\'"
  :interpreter "node"
  :config
  (setq tab-width 2)
  (setq indent-tabs-mode nil))

;; vue-mode
(use-package vue-mode
  :mode "\\.vue\\'"
  :commands (vue-mode)
  :config
  (setq mmm-submode-decoration-level 0)
  :custom
  (setq tab-width 2)
  (setq indent-tabs-mode nil)
  (vue-js-indent-offset 2))

;; web-mode
(use-package web-mode
  :mode ("\\.vue\\'" "\\.wxml\\'")
  :config
  ;; 这里就是设置一下缩进为2个空格
  (setq web-mode-indent-level 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))


;; indent set
;; (setq custom-tab-width 2)
(setq-default  tab-width 2) ;; 表示一个 tab 4个字符宽
(setq-default indent-tabs-mode nil) ;; nil 表示将 tab 替换成空格

;; (setq-default python-indent-offset custom-tab-width)
;; (setq-default vue-indent-offset 2)
;; (setq-default electric-indent-inhibit t)

;;web-mode
(use-package web-mode
  :custom-face
  (css-selector ((t (:inherit default :foreground "#66CCFF"))))
  (font-lock-comment-face ((t (:foreground "#828282"))))
  :mode
  ("\\.phtml\\'" "\\.tpl\\.php\\'" "\\.[agj]sp\\'" "\\.as[cp]x\\'"
   "\\.erb\\'" "\\.mustache\\'" "\\.djhtml\\'" "\\.[t]?html?\\'"))

;; lsp-bridge
(add-to-list 'load-path "~/.emacs.d/site-lisp/lsp-bridge")

(require 'yasnippet)
(yas-global-mode 1)

(require 'lsp-bridge)
(global-lsp-bridge-mode)


(provide 'init-programming)
