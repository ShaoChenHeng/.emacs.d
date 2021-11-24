;; elfeed
(add-to-list 'load-path "~/.emacs.d/site-lisp/elfeed")
(global-set-key (kbd "C-x w") 'elfeed)
(setq elfeed-feeds
      '("https://www.oschina.net/news/rss"
        ))
