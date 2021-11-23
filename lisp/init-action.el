;; Standard emacs's behavior

;; Enter directly after selecting the text without deleting
(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

(provide 'init-action)
