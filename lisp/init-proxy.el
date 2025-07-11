;;(setq url-gateway-method 'socks)
;;(setq socks-server '("Default server" "127.0.0.1" 8118 5))

;; (add-to-list 'load-path "~/.emacs.d/site-lisp/proxy-mode")

;; (setq url-gateway-local-host-regexp
;;      (concat "\\`" (regexp-opt '("localhost" "127.0.0.1")) "\\'"))

(require 'socks)
(setq url-gateway-method 'socks) ;; 设置 Emacs 的网络请求走 SOCKS
(setq socks-server '("Clash SOCKS" "127.0.0.1" 7897 5)) ;; 配置 SOCKS5 代理
(provide 'init-proxy)
