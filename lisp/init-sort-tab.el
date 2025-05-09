(add-to-list 'load-path "~/.emacs.d/site-lisp/sort-tab/")
(require 'sort-tab)

(let ((bg-color (face-attribute 'default :background))
      (fg-color (face-attribute 'default :foreground))
      (string-color (face-attribute 'font-lock-string-face :foreground))
      (key-color (face-attribute 'font-lock-keyword-face :foreground)))
  (custom-set-faces

   `(sort-tab-current-tab-face
     ((t (:family "Comic Mono"
                  :height 180
                  :background ,bg-color
                  :foreground ,key-color
		  :weight bold
		  :underline ,key-color
		  ))))
   `(sort-tab-other-tab-face
     ((t (:family "Comic Mono"
                  :height 180
                  :background ,bg-color
                  :foreground ,fg-color
		  :weight normal
		  ))))
   `(sort-tab-separator-face
     ((t(:foreground ,string-color :background ,bg-color :weight normal))))))

(setq sort-tab-show-index-number t)
(setq sort-tab-show-tab-icon t)
(sort-tab-mode 1)

(global-set-key (kbd "M-k") 'sort-tab-select-next-tab)
(global-set-key (kbd "M-j") 'sort-tab-select-prev-tab)

(provide 'init-sort-tab)
