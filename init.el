(add-to-list 'load-path
	     (expand-file-name(concat user-emacs-directory "lisp")))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'init-startup)
(require 'init-elpa)
(require 'init-ui)
(require 'init-package)
(require 'init-scheme)
(require 'init-paredit)

;; eaf
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/app/file-browser/")

(setq eaf-proxy-type "socks5")
(setq eaf-proxy-host "127.0.0.1")
(setq eaf-proxy-port "1080")
(require 'eaf)
(require 'eaf-browser)
(require 'eaf-rss-reader)
(require 'eaf-music-player)
(require 'eaf-file-manager)
(require 'eaf-file-browser)
(require 'eaf-vue-demo)

;; elfeed
(add-to-list 'load-path "~/.emacs.d/site-lisp/elfeed")
(global-set-key (kbd "C-x w") 'elfeed)
(setq elfeed-feeds
      '("https://www.oschina.net/news/rss"
        ))

;; use nano theme
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/nano-emacs")
;; (require 'nano)
