(use-package centaur-tabs
  :demand
  :init
  (setq centaur-tabs-enable-key-bindings t)
  :config
  (centaur-tabs-change-fonts "mononoki" 155)
  (setq
   centaur-tabs-set-bar 'left
   centaur-tabs-set-icons t
   centaur-tabs-set-modified-marker t
   centaur-tabs-icon-type 'nerd-icons
   nerd-icons-scale-factor 0.8
   centaur-tabs-show-new-tab-button nil
   centaur-tabs-modified-marker "•"
   centaur-tabs-cycle-scope 'tabs
   )
  ;;(centaur-tabs-headline-match)
  (centaur-tabs-mode t)

  :hook
  (dashboard-mode . centaur-tabs-local-mode)
  :bind
  ("M-j" . centaur-tabs-backward)
  ("M-k" . centaur-tabs-forward)
  ("M-s j" . centaur-tabs-move-current-tab-to-left)
  ("M-s k" . centaur-tabs-move-current-tab-to-right)
  )

(provide 'init-centaur-tabs)
