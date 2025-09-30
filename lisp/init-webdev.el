;; 设置保存后自动格式化代码
(use-package prettier-js
  :commands prettier-js-mode)

;; WebModePac
(use-package web-mode
  :mode
  ("\\.phtml\\'" "\\.tpl\\.php\\'" "\\.[agj]sp\\'" "\\.as[cp]x\\'" "\\.vue\\'"
   "\\.erb\\'" "\\.mustache\\'" "\\.djhtml\\'" "\\.[t]?html?\\'"
   "\\.xml\\'")
  :config
  (setq web-mode-markup-indent-offset 2)    ; HTML 缩进
  (setq web-mode-css-indent-offset 2)       ; CSS 缩进
  (setq web-mode-code-indent-offset 2)      ; JS/TS 缩进（在 <script> 内）
  (setq web-mode-attr-indent-offset 2)      ; 属性缩进（如 Vue 的 props）
  (setq web-mode-enable-css-colorization t) ; 开启 CSS 部分色值的展示：展示的时候会有光标显示位置异常
  (setq indent-tabs-mode nil)              ; 禁用 Tab，使用空格
  ;;一对标签高亮
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight nil)
  ;; 空格代替tab
  (setq-default indent-tabs-mode nil)
)

(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
(with-eval-after-load 'web-mode
  (add-to-list 'web-mode-engines-alist '("vue" . "\\.vue\\'"))
  (setq web-mode-content-types-alist
        '(("vue" . "\\.vue\\'"))))

;; (use-package emmet-mode
;;   :config
;;   (setq emmet-expand-jsx-className? t) ; 支持 JSX/Vue 的 class 绑定
;;   :hook ((web-mode . emmet-mode)
;;          (css-mode . emmet-mode)))

;; js
(use-package js2-mode
  :mode "\\.js\\'"
  :config
  (setq js2-mode-show-parse-errors nil)
  (setq js2-mode-show-strict-warnings nil)
  (setq js2-strict-missing-semi-warning nil)
  (setq js2-basic-offset 2))

(use-package auto-rename-tag
  :config
  (setq auto-rename-tag-use-functions t)
  :hook (web-mode . auto-rename-tag-mode))

;; instant-rename-tag
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/instant-rename-tag")
;; (require 'instant-rename-tag)
;; (global-set-key (kbd "C-c r") 'instant-rename-tag)

;;highlight-matching-tag
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/highlight-matching-tag")
;; (require 'highlight-matching-tag)
;; (highlight-matching-tag 1)

(custom-set-faces
 '(web-mode-html-tag-bracket-face ((t (:foreground "#df2b6c"))))
'(web-mode-current-element-highlight-face ((t (:background "#9d86f1"  :weight bold)))))

(add-hook 'web-mode-before-auto-complete-hooks
  (lambda ()
    (let ((web-mode-cur-language
           (web-mode-language-at-pos)))
      (if (string= web-mode-cur-language "javascript")
          (setq web-mode-code-indent-offset 2)))))

(add-hook 'web-mode-hook
          (lambda ()
            (setq web-mode-script-padding 0)))

;; auto-rename-tag会自动更改匹配的一对标签
;; 例如当我修改<h1>为<h2>, 那么</h1>会自动变</h2>
;; 但是由于自动修改完，</h2>就失去了配色
;; 所以下面这几个函数检测光标离开<>，自动刷新配色
;; (defvar my/web-mode-last-in-tag-p nil
;;   "记录上一次光标是否在 HTML 标签内部。")
(defvar my/web-mode-last-in-tag-p nil "记录上一次光标是否在 HTML 标签内部。")

(defun my/web-mode-in-tag-p ()
  "判断光标是否在 <...> HTML 标签内。"
  (let ((pos (point)))
    (and (eq major-mode 'web-mode)
         (get-text-property pos 'tag-type))))

(defun my/web-mode-fontify-on-leave-tag ()
  "当光标从标签内部离开时，自动刷新配色。"
  (let ((now-in-tag-p (my/web-mode-in-tag-p)))
    (when (and my/web-mode-last-in-tag-p (not now-in-tag-p))
      ;; 刚刚离开标签，刷新配色
      (font-lock-fontify-buffer))
    (setq my/web-mode-last-in-tag-p now-in-tag-p)))

(defun my/web-mode-auto-fontify-setup ()
  "在 web-mode 下启用自动刷新配色功能。"
  (add-hook 'post-command-hook #'my/web-mode-fontify-on-leave-tag nil t))

(add-hook 'web-mode-hook #'my/web-mode-auto-fontify-setup)

(provide 'init-webdev)
