(defun +setup-blur-kde (&rest ignores)
  (shell-command "sh ~/.emacs.d/blur.sh"))

(when (eq window-system 'x)
  (add-hook 'emacs-startup-hook #'+setup-blur-kde))
(provide 'init-kde-blur)
