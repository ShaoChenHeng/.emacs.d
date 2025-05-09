(use-package winum
  :ensure t
  :config
  (winum-mode 1))

(with-eval-after-load 'winum
  (add-to-list 'winum-ignored-buffers "*sort-tab*"))

(global-set-key (kbd "M-1") 'winum-select-window-1)
(global-set-key (kbd "M-2") 'winum-select-window-2)
(global-set-key (kbd "M-3") 'winum-select-window-3)
(global-set-key (kbd "M-4") 'winum-select-window-4)
(global-set-key (kbd "M-5") 'winum-select-window-5)

(provide 'init-winum)
