;; WebModePac
(use-package web-mode
  :custom-face
  (css-selector ((t (:inherit default :foreground "#66CCFF"))))
  (font-lock-comment-face ((t (:foreground "#828282"))))
  :mode
  ("\\.phtml\\'" "\\.tpl\\.php\\'" "\\.[agj]sp\\'" "\\.as[cp]x\\'" "\\.js\\'"
   "\\.erb\\'" "\\.mustache\\'" "\\.djhtml\\'" "\\.[t]?html?\\'" "\\.vue\\'")
  :config
  (setq web-mode-markup-indent-offset 2)    ; HTML 缩进
  (setq web-mode-css-indent-offset 2)       ; CSS 缩进
  (setq web-mode-code-indent-offset 2)      ; JS/TS 缩进（在 <script> 内）
  (setq web-mode-attr-indent-offset 2)      ; 属性缩进（如 Vue 的 props）
  (setq web-mode-attr-value-indent-offset 2); 属性值缩进
  (setq indent-tabs-mode nil)              ; 禁用 Tab，使用空格
  (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")) ; 支持 JSX
  ))

;; 配置 Vue 文件的区块语言
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "vue" (file-name-extension buffer-file-name))
              (web-mode-set-content-type "html") ; 模板部分为 HTML
              (web-mode-set-engine "vue")       ; 引擎设为 Vue
              )))

(use-package emmet-mode
  :config
  (setq emmet-expand-jsx-className? t) ; 支持 JSX/Vue 的 class 绑定

  :hook ((web-mode . emmet-mode)
         (css-mode . emmet-mode))
  )

;; JsonPac
(use-package json-mode
  :mode "\\.json\\'")

(add-to-list 'load-path "~/.emacs.d/site-lisp/instant-rename-tag")
(require 'instant-rename-tag)
(global-set-key (kbd "C-c r") 'instant-rename-tag)

(provide 'init-webdev)
