# My Emacs configuration

![dashboard](https://github.com/ShaoChenHeng/.emacs.d/blob/master/screenshot/3.png)

![code](https://github.com/ShaoChenHeng/.emacs.d/blob/master/screenshot/4.png)

## 界面增强
### init-ui.el

[Monokai主题](https://github.com/oneKelvinSmith/monokai-emacs) 

**关闭原始界面的各种工具**
```elisp
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-screen t)
```

**显示行号**
```elisp
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
```

**当前行高亮**
```elisp
(use-package hl-line
  :ensure nil
  :hook (after-init . global-hl-line-mode))
```

**字体设置**
```elisp
(when (display-graphic-p)  ; only gui
  ;; English font (Mono prefer)
  (set-face-attribute 'default nil
                      :family "monego"   ; font name
                      :weight 'regular   ; regular or bold
                      :height 180)       ; font size

  ;; 设置中文字体（覆盖CJK字符集）
  (dolist (charset '(kana han cjk-misc bopomofo))
    (set-fontset-font t charset
                      (font-spec :family "LXGW WenKai"   ; 霞鹜文楷
                                 :size 23))))            ; 中文字号
```

**当光标在括号中间高亮最近的一对括号**
```elisp
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     (funcall fn))))))
```

**选中区域代码反色**
```elisp
(defun my/region-highlight-if-whole-line ()
  "if the line selected inverse color"
  (when (and (region-active-p)
             (save-excursion
               (let ((beg (region-beginning))
                     (end (region-end)))
                 (and (<= (line-beginning-position) beg)
                      (>= (line-end-position) end)))))
    (face-remap-add-relative 'region '(:inverse-video t))))

(add-hook 'activate-mark-hook #'my/region-highlight-if-whole-line)
```

**更丝滑的屏幕滚动**
```elisp
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
(setq scroll-step 1)
(setq scroll-margin 1)
(setq scroll-conservatively 101)
(setq scroll-up-aggressively 0.01)
(setq scroll-down-aggressively 0.01)
(setq auto-window-vscroll nil)
(setq fast-but-imprecise-scrolling nil)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(pixel-scroll-precision-mode t)
```

**控制水平滚动字符数**
```elisp
(setq hscroll-step 1)
(setq hscroll-margin 1)
```

**全局符号美化模式**
将代码中的 lambda、-> 等符号自动显示为更美观的 Unicode 字符（如 λ、→），并在编程模式和 Org 模式中生效。
```elisp
(global-prettify-symbols-mode 1)
(defun add-pretty-lambda ()
  "Make some word or string show as pretty Unicode symbols.
   See https://unicodelookup.com for more."
  (setq prettify-symbols-alist
        '(("lambda" . 955)
          ("delta" . 120517)
          ("epsilon" . 120518)
          ("->" . 8594)
          ("<=" . 8804)
          (">=" . 8805))))
(add-hook 'prog-mode-hook 'add-pretty-lambda)
(add-hook 'org-mode-hook 'add-pretty-lambda)
```

**增删改代码特效**
它会在编辑代码或文本时高亮显示被修改（增/删/改）的代码块，并通过脉冲动画和自定义颜色（如绿色 #74F466 表示添加、蓝色 #00BBFF 表示更改、红色 #EE365A 表示删除）增强视觉反馈。
实际的使用过程中“改”的脉冲特效触发较少。
```elisp
(use-package goggles
  :hook ((prog-mode text-mode) . goggles-mode)
  :init
  (setq goggles-pulse t)
  :config
  (setq goggles-pulse-delay 0.06)
  (setq googles-pulse-iterations 500)
  (set-face-attribute 'goggles-added nil :background "#74F466")
  (set-face-attribute 'goggles-changed nil :background "#00BBFF")
  (set-face-attribute 'goggles-removed nil :background "#EE365A")
  (setq-default goggles-pulse t) ;; set to nil to disable pulsing
  )
```

**让Emacs更安静**
```elisp
(setq ring-bell-function 'ignore)
```

**更花里胡哨的dired**
显示更多色彩
```elisp
(add-to-list 'load-path "~/.emacs.d/site-lisp/diredfl")
(require 'diredfl)
(diredfl-global-mode 1)
```

显示文件图标
```elisp
(add-to-list 'load-path "~/.emacs.d/site-lisp/all-the-icons-dired")
(load "all-the-icons-dired.el")
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
```

**隐藏文件**
隐藏类似".emacs.d"和".gitignore"这样的文件，不在dired中显示
```elisp
(add-to-list 'load-path "~/.emacs.d/site-lisp/dired-hide-dotfiles")
(load "dired-hide-dotfiles")
(dired-hide-dotfiles-mode 1)
(defun my-dired-mode-hook ()
  "My `dired' mode hook."
  ;; To hide dot-files by default
  (dired-hide-dotfiles-mode))
(define-key dired-mode-map "." #'dired-hide-dotfiles-mode)
(add-hook 'dired-mode-hook #'my-dired-mode-hook)
```

### init-dashboard

具体效果：
![dashboard](https://github.com/ShaoChenHeng/.emacs.d/blob/master/screenshot/3.png)

随机显示一张图片在dashboard上:
```elisp
(setq dashboard-startup-banner
      (concat "~/.emacs.d/dashboardPic/pic/p"
	      (number-to-string (+ (% (caddr (current-time)) 23) 1))
	      ".png"))
 
(if (= (% (caddr (current-time)) 2) 0)
    (setq dashboard-startup-banner
          (concat "~/.emacs.d/dashboardPic/pic/p"
	                (number-to-string (+ (% (caddr (current-time)) 23) 1))
	                ".png"))
  (setq dashboard-startup-banner
        (concat "~/.emacs.d/dashboardPic/gif/"
	              (number-to-string (+ (% (caddr (current-time)) 19) 1))
	              ".gif")))
```

### init-doom-modeline

*doom-modeline的高度会受到全局字体大小的影响，全局字体越大，doom-modeline的高度就越高。*

**pikachu-mode**
项目地址: [pikachu-mode](https://github.com/ShaoChenHeng/pikachu-mode)
仿照[parrot-mode](https://github.com/dp12/parrot)实现的。皮卡丘有静坐和奔跑两种状态，在光标移动时触发奔跑状态，光标不移动时触发静坐状态。将皮卡丘显示在doom-modeline上。

```elisp
(doom-modeline-def-segment pikachu
  "Display pikachu animation in doom-modeline"
  (when (and (bound-and-true-p pikachu-mode) 
             (not (active-minibuffer-window)))
    (propertize " " 'display (pikachu-get-anim-frame))))
	
(doom-modeline-def-modeline 'main
  '(bar pikachu matches buffer-info buffer-position selection-info)
  '(misc-info lsp vcs checker))
(setq doom-modeline-mode-line 'main)
(doom-modeline-mode 1)

;; pikachu hook
(add-hook 'post-command-hook (lambda () (pikachu-start-animation)))
(add-hook 'emacs-idle-hook (lambda () (pikachu-stop-animation)))
```
控制doom-modeline的字体与buffer字体不同，产生对比。
```elisp
(if (facep 'mode-line-active)
    (set-face-attribute 'mode-line-active nil :family "mononoki" :height 180) ; For 29+
  (set-face-attribute 'mode-line nil :family "mononoki" :height 180))
(set-face-attribute 'mode-line-inactive nil :family "mononoki" :height 180)
```

### init-treemacs

在左侧生成一个项目列表。项目地址：[treemacs](https://github.com/Alexander-Miller/treemacs)
更改treemacs的原始图标:
```elisp
(add-to-list 'load-path "~/.emacs.d/site-lisp/treemacs-nerd-icons")
(require 'treemacs-nerd-icons)

(treemacs-load-theme "nerd-icons")
```

我的这个配置无法通过鼠标点击展开文件夹和打开文件，还在研究如何解决。

### init-alpha

更加花里胡哨的透明化配置，和Gnome的[blur-my-shell](https://extensions.gnome.org/extension/3193/blur-my-shell/)配合使用效果更佳。

在 dashboard 中几乎完全透明，可以配合桌面壁纸观赏。在其他的buffer中透明度较低，不妨碍编程。

## 编辑增强

### init-editing

**启用“删除选择模式”**

选中一段文本后，直接输入新内容或按删除键时，会自动删除选中的文本并替换为新内容，类似vs-code和sublime的操作逻辑。
```elisp
(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))
```

**多行注释**

```elisp
(global-set-key (kbd "C-?") 'comment-or-uncomment-region)
```


