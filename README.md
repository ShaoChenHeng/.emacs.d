# My Emacs configuration

![dashboard](https://github.com/ShaoChenHeng/.emacs.d/blob/master/screenshot/3.png)

![code](https://github.com/ShaoChenHeng/.emacs.d/blob/master/screenshot/4.png)

## 界面增强
### init-ui.el

#### Monokai-Emacs

[Monokai主题](https://github.com/oneKelvinSmith/monokai-emacs)

#### 关闭原始界面的各种工具

```elisp
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-screen t)
```

#### display-line-numbers-mode

```elisp
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
```

#### hl-line

当前行高亮
```elisp
(use-package hl-line
  :ensure nil
  :hook (after-init . global-hl-line-mode))
```

#### 字体设置
最主要的是：
- [monego](https://github.com/cseelus/monego)
- [霞鹜文楷](https://github.com/lxgw/LxgwWenKai)

其他的配置字体在这里也一并给出：
- [comic mono](https://github.com/wayou/comic-mono-font)，sort-tab的字体。
- [mononoki](https://github.com/madmalik/mononoki)，doom-modeline的字体。
- [Pokemon Solid](https://font.download/font/pokemon-solid-2)，winum的字体，特点是像手写体，并且特别醒目。
- [Hack](https://github.com/source-foundry/Hack)，treemacs的字体。

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

#### Highlight enclosing parens
当光标在括号中间高亮最近的一对括号
```elisp
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     (funcall fn))))))
```

#### 选中区域代码反色

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

#### 更丝滑的屏幕滚动

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

以下设置控制水平滚动字符数：

```elisp
(setq hscroll-step 1)
(setq hscroll-margin 1)
```

#### pretty-symbols

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
#### goggles

它会在编辑代码或文本时高亮显示被修改（增/删/改）的代码块，并通过脉冲动画和自定义颜色（如绿色 #74F466 表示添加、蓝色 #00BBFF 表示更改、红色 #EE365A 表示删除）增强视觉反馈。

实际的使用中“改”的脉冲特效触发较少。

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

#### 让Emacs更安静

```elisp
(setq ring-bell-function 'ignore)
```

#### dired

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

### init-kaomoji-title-bar

项目地址:[kaomoji-title-bar](https://github.com/shaochenheng/kaomoji-title-bar/)

在标题栏显示一个颜文字，并且在光标移动时发生变化。

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

#### pikachu-mode
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

### sort-tab

项目地址：[sort-tab](https://github.com/manateelazycat/sort-tab)

在Emacs窗口的上方显示一排标签栏。

### init-alpha

更加花里胡哨的透明化配置，和Gnome的[blur-my-shell](https://extensions.gnome.org/extension/3193/blur-my-shell/)配合使用效果更佳。

在 dashboard 中几乎完全透明，可以配合桌面壁纸观赏。在其他的buffer中透明度较低，不妨碍编程。

## 编辑增强

### init-editing

#### delsel

启用“删除选择模式”，选中一段文本后，直接输入新内容或按删除键时，会自动删除选中的文本并替换为新内容，类似vs-code和sublime的操作逻辑。
```elisp
(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))
```

#### 多行注释

```elisp
(global-set-key (kbd "C-?") 'comment-or-uncomment-region)
```

#### iedit-mode

对当前选中文本打开iedit-mode,可以对buffer内的所有该字符串进行编辑，在进行大量的搜索替换时，会起到作用。

```elisp
(add-to-list 'load-path "~/.emacs.d/site-lisp/iedit/")
(require 'iedit)
(global-set-key (kbd "M-s e") 'iedit-mode)
```

#### move-text

对光标所在行的文本进行上下移动，这个功能在vscode和sublime中也有。

```elisp
(add-to-list 'load-path "~/.emacs.d/site-lisp/move-text/")
(require 'move-text)
(global-set-key (kbd "C-<up>") 'move-text-up)
(global-set-key (kbd "C-<down>") 'move-text-down)
```

#### 调整buffer大小

可以从四个方向调整buffer的大小

```elisp
;; 向左扩大窗口（通过向右缩小相邻窗口实现）
(defun my/enlarge-window-left ()
  "向左扩大当前窗口宽度"
  (interactive)
  (shrink-window-horizontally -1)) ; 负数表示反向操作

;; 向上扩大窗口（通过向下缩小相邻窗口实现）
(defun my/enlarge-window-up ()
  "向上扩大当前窗口高度"
  (interactive)
  (shrink-window -1)) ; 负数表示反向操作

;; 绑定快捷键
(global-set-key (kbd "M-<left>")  'my/enlarge-window-left)   ; 向左扩大
(global-set-key (kbd "M-<right>") 'enlarge-window-horizontally) ; 向右扩大
(global-set-key (kbd "M-<up>")    'my/enlarge-window-up)     ; 向上扩大
(global-set-key (kbd "M-<down>")  'enlarge-window)           ; 向下扩大
```

#### watch-other-window

在多个窗口编辑的时候，假如正在编辑窗口1,可以通过这个插件移动窗口2的代码。

```elisp
(add-to-list 'load-path "~/.emacs.d/site-lisp/watch-other-window")
(require 'watch-other-window)
(global-set-key (kbd "C--")  'watch-other-window-down)
(global-set-key (kbd "C-=")  'watch-other-window-up)
(global-set-key (kbd "M--")  'watch-other-window-down-line)
(global-set-key (kbd "M-=")  'watch-other-window-up-line)
```

#### auto-save

自动保存

```elisp
(add-to-list 'load-path "~/.emacs.d/site-lisp/watch-other-window")
(require 'watch-other-window)
(global-set-key (kbd "C--")  'watch-other-window-down)
(global-set-key (kbd "C-=")  'watch-other-window-up)
(global-set-key (kbd "M--")  'watch-other-window-down-line)
(global-set-key (kbd "M-=")  'watch-other-window-up-line)
(setq auto-save-disable-predicates
      '((lambda ()
      (string-suffix-p
      "gpg"
      (file-name-extension (buffer-name)) t))))
```

#### goto-line-preview

在进行行跳转前，可以现预览要跳转到的行位置。

``` elisp
(add-to-list 'load-path "~/.emacs.d/site-lisp/goto-line-preview")
(require 'goto-line-preview)
(global-set-key (kbd "M-g M-g")  'goto-line-preview)
;; Highlight 1.5 seconds when change preview line
(setq goto-line-preview-hl-duration 1.5)

;; Change highlight background color to white
(set-face-background 'goto-line-preview-hl "#5a94f5")
```

### 窗口管理

#### winum

对窗口进行编号，使用"M-1"、"M-2"之类快捷键进行快速切换。

```elisp
(use-package winum
  :ensure t
  :config
  (winum-mode 1))

(with-eval-after-load 'winum
  (add-to-list 'winum-ignored-buffers "*sort-tab*"))

(global-set-key (kbd "M-1") 'winum-select-window-1)
(global-set-key (kbd "M-2") 'winum-select-window-2)
(global-set-key (kbd "M-3") 'winum-select-window-3)
(global-set-key (kbd "M-4") 'winum-select-window-4)
(global-set-key (kbd "M-5") 'winum-select-window-5)

(provide 'init-winum)
```

可以将编号显示在doom-modeline上。

```elisp
(doom-modeline-def-segment window-number
  (when (featurep 'winum)
    (propertize (format " %s " (winum-get-number-string))
                'face '(
			:family "Pokemon Solid"
			:foreground "#f6f6f4"
			:background "#ac86f1"
			:weight bold))))
```

#### ace-window

通过`C-x C-o`进入ace-window,按数字进行窗口切换。（切换速度不如winum）

```elisp
(add-to-list 'load-path "~/.emacs.d/site-lisp/ace-window")
(require 'ace-window)
(setq aw-background t)
(set-face-attribute 'aw-background-face nil
                    :background "grey"       ; 背景色改为红色
                    :foreground "#676863"     ; 字符颜色白色
                    :weight 'bold)

(global-set-key (kbd "C-x C-o") 'ace-window)
```

`?x`和`?m`等可以进一步操作。

```elisp
(defvar aw-dispatch-alist
  '((?x aw-delete-window "Delete Window")
	(?m aw-swap-window "Swap Windows")
	(?M aw-move-window "Move Window")
	(?c aw-copy-window "Copy Window")
	(?j aw-switch-buffer-in-window "Select Buffer")
	(?n aw-flip-window)
	(?u aw-switch-buffer-other-window "Switch Buffer Other Window")
	(?c aw-split-window-fair "Split Fair Window")
	(?v aw-split-window-vert "Split Vert Window")
	(?b aw-split-window-horz "Split Horz Window")
	(?o delete-other-windows "Delete Other Windows")
	(?? aw-show-dispatch-help))
  "List of actions for `aw-dispatch-default'.")
```
