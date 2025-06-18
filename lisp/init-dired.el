(use-package dired
  :ensure nil
  :bind
  (("C-x C-j" . dired-jump))
  :custom
  ;; Always delete and copy recursively
  (dired-listing-switches "-lah")
  (dired-recursive-deletes 'always)
  (dired-recursive-copies 'always)
  ;; Auto refresh Dired, but be quiet about it
  (global-auto-revert-non-file-buffers t)
  (auto-revert-verbose nil)
  ;; Quickly copy/move file in Dired
  (dired-dwim-target t)
  ;; Move files to trash when deleting
  (delete-by-moving-to-trash t)
  ;; Load the newest version of a file
  (load-prefer-newer t)
  ;; Detect external file changes and auto refresh file
  (auto-revert-use-notify nil)
  (auto-revert-interval 3) ; Auto revert every 3 sec
  :config
  ;; Enable global auto-revert
  (global-auto-revert-mode t)
  ;; Reuse same dired buffer, to prevent numerous buffers while navigating in dired
  (put 'dired-find-alternate-file 'disabled nil)
  :hook
  (dired-mode . (lambda ()
                  (local-set-key (kbd "RET") #'dired-find-alternate-file)
                  (local-set-key (kbd "~")
                                 (lambda () (interactive) (find-alternate-file ".."))))))

;; colorful dired
(add-to-list 'load-path "~/.emacs.d/site-lisp/diredfl")
(require 'diredfl)
(diredfl-global-mode 1)


;; show icons in dired
(add-to-list 'load-path "~/.emacs.d/site-lisp/all-the-icons-dired")
(load "all-the-icons-dired.el")
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; hide or show .xxxx files in dired
(add-to-list 'load-path "~/.emacs.d/site-lisp/dired-hide-dotfiles")
(load "dired-hide-dotfiles")
(dired-hide-dotfiles-mode 1)
(defun my-dired-mode-hook ()
  "My `dired' mode hook."
  ;; To hide dot-files by default
  (dired-hide-dotfiles-mode))
(define-key dired-mode-map "." #'dired-hide-dotfiles-mode)
(add-hook 'dired-mode-hook #'my-dired-mode-hook)

(provide 'init-dired)
