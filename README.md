# My Emacs configuration

![dashboard](./screenshot/3.png)

![code](./screenshot/4.png)

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
英文字体和中文字体分别是：
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

![selected-code](./screenshot/selected-code.png)

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

#### ident-bars

类似sublime的增强缩进显示。

![ident-bars](./screenshot/ident-bars.png)

```elisp
(add-to-list 'load-path "~/.emacs.d/site-lisp/indent-bars")
(require 'indent-bars)
(setq indent-bars-width-frac 0.15) ;; 控制线条粗细
(add-hook 'prog-mode-hook 'indent-bars-mode)
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

![kaomoji-title-bar](./screenshot/kaomoji-title-bar.png)

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
![pikachu-mode](./screenshot/pikachu-mode.png)
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

#### popper

将一些弹出窗口标记为‘POP’，通过`C+` `能够快速关闭和开启，防止破坏原有的buffer布局。

[poper](https://github.com/karthink/popper)

#### awesome-pair

括号匹配插件。

[awesom-pair](https://github.com/manateelazycat/awesome-pair)

#### lsp-bridge

代码补全插件。

[lsp-bridge](https://github.com/manateelazycat/lsp-bridge)

### 搜索增强

#### ivy, counsel, swiper

在ivy中按tab有两个功能，如果还能继续匹配则补全，如果不能继续匹配就进入（确认）该项。但是如果不存在该项就会报错。报错太烦人了，于是我就设置回车为确认。

```elisp
(use-package ivy
  :defer 1
  :demand
  :hook (after-init . ivy-mode)
  :config

  (define-key ivy-minibuffer-map (kbd "TAB") #'ivy-partial)
  ;; 回车直接确认选择
  (define-key ivy-minibuffer-map (kbd "<return>") #'ivy-done)

  ;; 反色选中项
  (set-face-attribute 'ivy-current-match nil
                      :inverse-video t
                      :weight 'bold)
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-height 10)
  (ivy-on-del-error-function nil)
  (ivy-magic-slash-non-match-action 'ivy-magic-slash-non-match-create)
  (ivy-count-format "【%d/%d】")
  (ivy-wrap t))
```

在counsel中添加需要开启的搜索增强功能，但是似乎即使不添加也会默认开启。因为我不喜欢增强版find-file，它的排序逻辑是字典序优先级更高，而原始find-file的逻辑是最长字符串匹配的优先级更高，我十分不习惯增强版find-file.所以在这里并没有开启，然而它还是给我开启了。

```elisp
(use-package counsel
  :ensure t
  :after ivy
  :bind (("M-x" . counsel-M-x)          ; 增强版M-x
         ("C-x b" . counsel-switch-buffer) ; 增强版缓冲区切换
         ("C-c g" . counsel-git)        ; Git文件搜索
         ("C-c j" . counsel-git-grep)   ; Git内容搜索
         ("C-c k" . counsel-ag)         ; ag搜索
         ("C-x l" . counsel-locate))    ; 系统文件搜索
  :config
  (setq counsel-mode-override-describe-bindings nil))
```

于是我又在下方添加了这个配置，使用原始的find-file。

```elisp
(defun my-find-file()
  (interactive)
  (ivy-mode -1)
  (call-interactively 'find-file)
  (ivy-mode 1))
(global-set-key (kbd "C-x C-f") 'my-find-file)
```

### AI辅助

#### aidermacs

项目地址：[aidermacs](https://github.com/MatthewZMD/aidermacs)

一个安全的做法是设置一个AI接口的key到环境变量中，再从配置文件中引用这个环境变量。

从起动器打开Emacs使用aidermacs会提示找不到aider，所以我增加了这个设置：

```elisp
(setenv "DEEPSEEK_API_KEY" (getenv "DEEPSEEK_API_KEY_FROM_ENV"))
```

#### copilot.el

项目地址：[copilot.el](https://github.com/copilot-emacs/copilot.el)

和aidermacs那种聊天式的AI文本生成不同，copilot.el更像是生成代码补全，根据当前项目上下文推断可能代码段，然后用户进行补全。

配合lsp-bridge，在emacs上的代码补全功能已经十分不错了。

比较奇怪的一个地方是，我设置了补全缩进为2空格，但是似乎不起作用。

``` elisp
(add-to-list 'load-path "~/.emacs.d/site-lisp/copilot.el")
(require 'copilot)
;;(add-hook 'prog-mode-hook 'copilot-mode)
(add-hook 'pyton-mode-hook 'copilot-mode)
(add-hook 'js-mode-hook 'copilot-mode)
(add-hook 'web-mode-hook 'copilot-mode)

(add-to-list 'copilot-indentation-alist '(prog-mode 2))
(add-to-list 'copilot-indentation-alist '(web-mode 2))
(add-to-list 'copilot-indentation-alist '(python-mode 2))
(add-to-list 'copilot-indentation-alist '(js2-mode 2))
(add-to-list 'copilot-indentation-alist '(java-mode 2))

;; 全部补全
(define-key copilot-completion-map (kbd "M-?") 'copilot-accept-completion)
;; 按字接受 Copilot 补全
(define-key copilot-completion-map (kbd "M-'") 'copilot-accept-completion-by-word)

(custom-set-faces
 '(copilot-overlay-face ((t (:foreground "#d3edcf" :background "#406539" :italic t)))))

(provide 'init-copilot)
```

### 多种语言针对性配置

#### webmode

```elisp
(use-package web-mode
  :custom-face
  (css-selector ((t (:inherit default :foreground "#66CCFF"))))
  (font-lock-comment-face ((t (:foreground "#828282"))))
  :mode
  ("\\.phtml\\'" "\\.tpl\\.php\\'" "\\.[agj]sp\\'" "\\.as[cp]x\\'" "\\.js\\'"
   "\\.erb\\'" "\\.mustache\\'" "\\.djhtml\\'" "\\.[t]?html?\\'" "\\.vue\\'"
   "\\.xml\\'"
   )
  :config
  (setq web-mode-markup-indent-offset 2)    ; HTML 缩进
  (setq web-mode-css-indent-offset 2)       ; CSS 缩进
  (setq web-mode-code-indent-offset 2)      ; JS/TS 缩进（在 <script> 内）
  (setq web-mode-attr-indent-offset 2)      ; 属性缩进（如 Vue 的 props）
  (setq web-mode-attr-value-indent-offset 2); 属性值缩进
  (setq indent-tabs-mode nil)              ; 禁用 Tab，使用空格
  (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")) ; 支持 JSX
  ))

(add-hook 'web-mode-hook
	(lambda ()
	(when (string-equal "vue" (file-name-extension buffer-file-name))
		(web-mode-set-content-type "html") ; 模板部分为 HTML
		(web-mode-set-engine "vue")       ; 引擎设为 Vue
)))
```

#### emmet-mode

[emmet-mode](https://github.com/smihica/emmet-mode)

```elisp
(use-package emmet-mode
  :config
  (setq emmet-expand-jsx-className? t) ; 支持 JSX/Vue 的 class 绑定

  :hook ((web-mode . emmet-mode)
         (css-mode . emmet-mode))
  )
```

#### auto-rename-tag

在编辑css的标签时，同步修改一对标签。例如在修改` <h1> `时候，`</h1>`会产生同样的修改

```elisp
(use-package auto-rename-tag
  :config
  (setq auto-rename-tag-use-functions t)
  :hook (web-mode . auto-rename-tag-mode))
```
