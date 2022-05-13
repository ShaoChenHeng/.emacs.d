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
(require 'eaf-file-browser)
;; (require 'eaf-netease-cloud-music)
(require 'eaf-org-previewer)
(require 'eaf-pdf-viewer)
(require 'eaf-jupyter)

(provide 'init-eaf)
