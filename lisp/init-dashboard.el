(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-dashboard")
(require 'dashboard)

(add-to-list 'load-path "~/.emacs.d/site-lisp/all-the-icons.el")
(require 'all-the-icons)

(add-to-list 'load-path "~/.emacs.d/site-lisp/page-break-lines")
(require 'page-break-lines)

(add-to-list 'load-path "~/.emacs.d/site-lisp/projectile")
(require 'projectile)

(dashboard-setup-startup-hook)
;; Set the title
(setq dashboard-banner-logo-title "Hello World!")
;; Set the banner

(setq dashboard-startup-banner
      (concat "/home/scheng/.emacs.d/dashboardPic/nico/nico"
	      (number-to-string (+ (% (caddr (current-time)) 6) 1))
	      ".png"))

;; Value can be
;; 'official which displays the official emacs logo
;; 'logo which displays an alternative emacs logo
;; 1, 2 or 3 which displays one of the text banners
;; "path/to/your/image.gif", "path/to/your/image.png" or "path/to/your/text.txt" which displays whatever gif/image/text you would prefer

;; Content is not centered by default. To center, set
(setq dashboard-center-content t)

;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts nil)

(setq dashboard-items '((recents  . 10)
                        ))
(defun dashboard-insert-custom (list-size))
(add-to-list 'dashboard-item-generators  '(custom . dashboard-insert-custom))
(add-to-list 'dashboard-items '(custom) t)

(setq dashboard-item-names '(("Recent Files:" . "Recently opened files:")
                             ("Agenda for today:" . "Today's agenda:")
                             ("Agenda for the coming week:" . "Agenda:")))

(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)

(dashboard-modify-heading-icons '((recents . "file-text")
                                  (bookmarks . "book")))

(setq dashboard-set-navigator t)

;; Format: "(icon title help action face prefix suffix)"
(setq dashboard-navigator-buttons
   (if (featurep 'all-the-icons)
       `(((,(all-the-icons-octicon "mark-github" :height 1.1 :v-adjust -0.05)
           "GitHub" "Browse GitHub Homepage"
           (lambda (&rest _) (browse-url "https://github.com/shaochenheng")))
          (,(all-the-icons-fileicon "elisp" :height 1.0 :v-adjust -0.1)
           "Configuration" "" (lambda (&rest _) (edit-configs)))
          (,(all-the-icons-faicon "cogs" :height 1.0 :v-adjust -0.1)
           "Update" "" (lambda (&rest _) (auto-package-update-now)))))
     `((("" "M-EMACS" "Browse M-EMACS Homepage"
         (lambda (&rest _) (browse-url "https://github.com/shaochenheng")))
        ("" "Configuration" "" (lambda (&rest _) (edit-configs)))
        ("" "Update" "" (lambda (&rest _) (auto-package-update-now)))))))

(setq dashboard-set-init-info t)

(setq dashboard-init-info "It all returns to nothing.")

(setq dashboard-set-footer nil)

(setq dashboard-footer-messages '("Hello World!"))
(setq dashboard-footer-icon (all-the-icons-octicon "dashboard"
                                                   :height 1.1
                                                   :v-adjust -0.05
                                                   :face 'font-lock-keyword-face))

(provide 'init-dashboard)
