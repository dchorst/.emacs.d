(defun reload-config ()
    (interactive)
    (org-babel-load-file "~/.emacs.d/config.org"))
  (defun config ()
    (interactive)
    (find-file "~/.emacs.d/config.org"))
  (global-set-key (kbd "C-c r c") 'reload-config)
  (global-set-key (kbd "C-c o c") 'config)

(defun dch-kill-whole-word ()
  (interactive)
  (backward-word)
  (kill-word 1))
(global-set-key (kbd "C-c k w") 'dch-kill-whole-word)

(defun dch-kill-curr-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'dch-kill-curr-buffer)

(defun dch-kill-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
(global-set-key (kbd "C-M-s-k") 'dch-kill-all-buffers)

(defun dch-copy-whole-line ()
  (interactive)
  (save-excursion
    (kill-new
     (buffer-substring
      (point-at-bol)
      (point-at-eol)))))
(global-set-key (kbd "C-c w l") 'dch-copy-whole-line)

;; Set user name and contact info

(setq user-full-name "Doug Horst"
      user-mail-address "dchorst@gmail.com"
      user-login-name "dchorst")

(setq ring-bell-function 'ignore)
(setq auto-revert-verbose nil)

;; ui elements

(tool-bar-mode -1)
(scroll-bar-mode -1)
;;(menu-bar-mode -1)

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(setq-default fill-column 80)
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)

;;; Opening geometry

(add-to-list 'default-frame-alist '(height . 60))
(add-to-list 'default-frame-alist '(width . 235))
;;; Minimal fringe
(fringe-mode '(4 . 4))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items ' ((recents . 10)))
  (setq dashboard-banner-logo-title "Welcome Back"))

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(blink-cursor-mode -1)
(setq blink-cursor-blinks 0)
(when window-system (global-hl-line-mode t))
(make-variable-buffer-local 'global-hl-line-mode)

(use-package beacon
  :ensure t
  :init
  (beacon-mode 1)
  (setq beacon-push-mark 35)
  (setq beacon-color "#666600"))

;; Newline at end of file
(setq require-final-newline t)

;; Use 'y' or 'n' instead of 'yes' or 'no'
(fset 'yes-or-no-p 'y-or-n-p)

;; delete the selection with a keypress
(delete-selection-mode t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Natural reading, wrap at the word
(setq-default word-wrap 1)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 3)
(setq-default tab-stop-list (number-sequence 3 120 3))
(setq c-basic-indent 3)
(setq sh-basic-offset 3)

(use-package aggressive-indent
   :ensure t
   :config
       (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
       (add-hook 'clojure-mode-hook #'aggressive-indent-mode)
       (add-hook 'lisp-mode-hook #'aggressive-indent-mode)
)

(use-package rainbow-mode
  :ensure t
  :init
    (add-hook 'prog-mode-hook 'rainbow-mode))

(use-package org-bullets
  :ensure t
  :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(when window-system
      (use-package pretty-mode
      :ensure t
      :config
      (global-pretty-mode t)))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(use-package darktooth-theme
   :ensure t
   :config
     (load-theme 'darktooth 'no-confirm))

(set-face-attribute 'default nil :family "Source Code Pro" :height 120 )
(set-frame-font  "inconsolata" nil t)
(set-face-attribute 'fringe nil :background "#2d2d2d")
(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
(set-face-attribute 'font-lock-comment-face nil :weight 'semibold)
(set-fontset-font "fontset-default" 'unicode "DejaVu Sans Mono for Powerline")

(when window-system (global-prettify-symbols-mode t))

(setq version-control t        ;; OpenVMS-esque
      backup-by-copying t      ;; Copy-on-write-esque
      kept-new-versions 64     ;; Indeliable-ink-esque
      kept-old-versions 0      ;; 
      delete-old-versions nil  ;; 
      )
(setq backup-directory-alist   ;; Save backups in $(pwd)/.bak
      '(("." . ".bak"))        ;;
      )

; Disable auto-saving
(setq auto-save-default nil)

(setq dired-recursive-copies 'always)
(setq dired-recursive-deleted 'always)
(setq dired-dwim-target t)
(setq dired-listing-switches "-alh")

(global-auto-revert-mode t)
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
(global-set-key (kbd "<f5>") 'revert-buffer)

(use-package dired-details
   :ensure t
   :config
   (setq dired-details-hidden-string "")
)

(require 'linum)
(set-face-attribute 'linum nil
                    :background (face-attribute 'default :background)
                    :foreground (face-attribute 'font-lock-comment-face :foreground))
(defface linum-current-line-face
  `((t :background "gray30" :foreground "black"))
  "Face for the currently active Line number")
(defvar my-linum-current-line-number 0)
(defun get-linum-format-string ()
  (setq-local my-linum-format-string
              (let ((w (length (number-to-string
                                (count-lines (point-min) (point-max))))))
                (concat " %" (number-to-string w) "d "))))
(add-hook 'linum-before-numbering-hook 'get-linum-format-string)
(defun my-linum-format (line-number)
  (propertize (format my-linum-format-string line-number) 'face
              (if (eq line-number my-linum-current-line-number)
                  'linum-current-line-face
                'linum)))
(setq linum-format 'my-linum-format)
(defadvice linum-update (around my-linum-update)
  (let ((my-linum-current-line-number (line-number-at-pos)))
    ad-do-it))
(ad-activate 'linum-update)

(defun num ()
  (interactive)
  (if (bound-and-true-p relative-line-numbers-mode)
      (relative-line-numbers-mode 'toggle))
  (linum-mode 'toggle))
(defun rnum ()
  (interactive)
  (if (bound-and-true-p linum-mode)
      (linum-mode 'toggle))
  (relative-line-numbers-mode 'toggle))

(column-number-mode 1)
(use-package powerline
  :ensure t
  :config
     (powerline-center-theme)
)
;; compact mode-line
(use-package smart-mode-line
  :ensure t
  :defer t)
 ;; hey where is my clock ?
  (setq display-time-format " %H:%M %b %d %a ")
  (display-time-mode 1)

(use-package ace-window
   :ensure t
   :init
   (progn
     (setq aw-scope 'frame)
     (global-set-key (kbd "C-x O") 'other-frame)
     (global-set-key [remap other-window] 'ace-window)
     (custom-set-faces
      '(aw-leading-char-face
        ((t (:inherit ace-jump-face-foreground :height 3.0)))))
     ))

(show-paren-mode 1)
(setq show-paren-delay 0)

(use-package rainbow-delimiters
   :ensure t
   :config
     (set-face-attribute 'rainbow-delimiters-depth-1-face nil
                         :foreground "#78c5d6")
     (set-face-attribute 'rainbow-delimiters-depth-2-face nil
                         :foreground "#bf62a6")
     (set-face-attribute 'rainbow-delimiters-depth-3-face nil
                         :foreground "#459ba8")
     (set-face-attribute 'rainbow-delimiters-depth-4-face nil
                         :foreground "#e868a2")
     (set-face-attribute 'rainbow-delimiters-depth-5-face nil
                         :foreground "#79c267")
     (set-face-attribute 'rainbow-delimiters-depth-6-face nil
                         :foreground "#f28c33")
     (set-face-attribute 'rainbow-delimiters-depth-7-face nil
                         :foreground "#c5d647")
     (set-face-attribute 'rainbow-delimiters-depth-8-face nil
                         :foreground "#f5d63d")
     (set-face-attribute 'rainbow-delimiters-depth-9-face nil
                         :foreground "#78c5d6")
)

(set-face-attribute 'rainbow-delimiters-unmatched-face nil
                    :foreground 'unspecified
                    :inherit 'show-paren-mismatch
                    :strike-through t)

(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'text-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; Paredit

(use-package paredit
  :ensure t
  :config
  (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
  (add-hook 'clojure-mode-hook          #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'pythonn-mode-hook          #'enable-paredit-mode)
  )
;; useful global keybindings from Endless Parentheses Blogpost 28-June-2016

(global-set-key (kbd "C-M-u") #'paredit-backward-up)
(global-set-key (kbd "C-M-n") #'paredit-forward-up)
;; This one's surpisingly useful for writing prose.
(global-set-key "\M-S" #'paredit-splice-sexp-killing-backward)
(global-set-key "\M-R" #'paredit-raise-sexp)
(global-set-key "\M-(" #'paredit-wrap-round)
(global-set-key "\M-[" #'paredit-wrap-square)
(global-set-key "\M-{" #'paredit-wrap-curly)

;; fix the paredit binding of M-q and set it back to fill-paragraph
(when (fboundp 'paredit-mode-map)
   (eval-after-load 'paredit
       (define-key paredit-mode-map (kbd "M-q") nil)))
(global-set-key (kbd "M-q") 'fill-paragraph)

(add-hook 'eval-expression-minibuffer-setup-hook #'paredit-mode)

(use-package ibuffer
   :ensure t
   :config
(setq my-ibuffer-filter-group-name "my-filters"))
(setq ibuffer-saved-filter-groups
      (list (nreverse
             `(("Directories" (mode . dired-mode))
               ("Magit" (name . "^\\*magit.*$"))
               ("Org" (mode . org-mode))
               ("Shell" (or (mode . term-mode)
                            (mode . eshell-mode)
                            (mode . shell-mode)))
               ("Global" (name . "^\\*.*\\*$"))
               ("Interactive" (or (mode . inferior-python-mode)
                                  (mode . inferior-lisp-mode)
                                  (mode . inferior-scheme-mode)
                                  (mode . ielm-mode)))
               ,my-ibuffer-filter-group-name))))

(defadvice ibuffer-generate-filter-groups
    (after reverse-ibuffer-groups () activate)
  (setq ad-return-value (nreverse ad-return-value)))

(setq ibuffer-show-empty-filter-groups nil)

(setq ibuffer-display-summary nil)

;; Use human readable Size column instead of original one
(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
   ((> (buffer-size) 100000) (format "%7.0fk" (/ (buffer-size) 1000.0)))
   ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
   (t (format "%8d" (buffer-size)))))

;; Modify the default ibuffer-formats
(setq ibuffer-formats
      '((mark modified read-only " "
              (name 40 60 :left :elide)
              " "
              (size-h 9 -1 :right)
              " "
              (mode 16 16 :left :elide)
              " "
              filename-and-process)))

(defun my-ibuffer-hooks ()
  (ibuffer-auto-mode 1)
  (ibuffer-switch-to-saved-filter-groups my-ibuffer-filter-group-name)
  (no-trailing-whitespace))
(add-hook 'ibuffer-mode-hook 'my-ibuffer-hooks)

(defalias 'list-buffers 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(defvar my-term-shell "/usr/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(defadvice term-sentinel (around my-advice-term-sentinel (proc msg))
  (if (memq (process-status proc) '(signal exit))
      (let ((buffer (process-buffer proc)))
        ad-do-it
        (kill-buffer buffer))
    ad-do-it))
(ad-activate 'term-sentinel)

(defun term-toggle-mode ()
  (interactive)
  (if (term-in-line-mode)
      (term-char-mode)
    (term-line-mode)))

(defun my-term-hook ()
  (goto-address-mode)
  (local-set-key "\C-c\C-j" 'term-toggle-mode) ;; toggle line/char mode
  (local-set-key "\C-c\C-k" 'term-toggle-mode)
  (setq global-hl-line-mode nil)
  (setq term-buffer-maximum-size 10000)
  (setq-local ml-interactive? t) ;; for mode line
  (setq-local show-dir-in-mode-line? t) ;; also mode linec'
  (setq show-trailing-whitespace nil)
  ;; disable company in favor of shell completion
  (company-mode -1))
(add-hook 'term-mode-hook 'my-term-hook)

(defalias 'sh 'ansi-term)

(use-package better-shell
    :ensure t
    :bind (("C-'" . better-shell-shell)
           ("C-;" . better-shell-remote-open)))

(use-package counsel
  :ensure t
  :bind
  (("M-x" . counsel-M-x)
   ("M-y" . counsel-yank-pop)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line))
)

(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy)
  (setq ivy-count-format "%d/%d ")
)

(use-package swiper
  :ensure t
  :diminish ivy-mode
  :bind (("C-s" . swiper)
         ("C-c C-r" . ivy-resume)
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-M-i" . complete-symbol)
         ("C-." . counsel-imenu)
         ("C-c 8" . counsel-unicode-char)
         ("C-c v" . ivy-push-view)
         ("C-c V" . ivy-pop-view)
         ("M-y" . counsel-yank-pop))
  )

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))

(use-package flycheck
   :ensure t
   :init
     (global-flycheck-mode t)
)

(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install)
  )

(use-package org-pdfview
  :ensure t)

(use-package hungry-delete
  :ensure t
  :config (global-hungry-delete-mode)
          (setq backward-delete-char-untabify-method 'all))

(use-package define-word
  :ensure t
  :bind (("C-c d" . define-word-at-point)
         ("C-c D" . define-word))
  )

(use-package multiple-cursors
  :ensure t
  )
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(add-to-list 'org-structure-template-alist
             '("el" "#+BEGIN_SRC emacs-lisp :tangle yes\n?\n#+END_SRC"))

(custom-set-variables
  '(org-directory "~/Dropbox/orgfiles")
  '(org-default-notes-file (concat org-directory "/notes.org"))
  '(org-export-html-postamble nil)
  '(org-hide-leading-stars t)
  '(org-startup-folded (quote overview))
  '(org-startup-indented t)
    )

(setq org-agenda-files (list "~/Dropbox/orgfiles/gcal.org"
                             "~/Dropbox/orgfiles/life.org"
                             "~/Dropbox/orgfiles/work.org"
                             "~/Dropbox/orgfiles/tech.org"
                             "~/Dropbox/orgfiles/write.org"
                             "~/Dropbox/orgfiles/theo.org")
)

(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cb" 'org-switchb)

(setq org-capture-templates
   '(
     ("b" "Book Project")
     ("bs" "Scene" entry
      (file+headline "~/Dropbox/orgfiles/book-projects/scenes.org" "Scenes")
      (file "~/Dropbox/orgfiles/org-templates/tpl-book-scene.txt")
      :prepend t :empty-lines-before 1)
     ("bb" "Bio" entry
      (file+headline "~/Dropbox/orgfiles/book-projects/bios.org" "Biographies")
      (file "~/Dropbox/orgfiles/org-templates/tpl-book-bio.txt")
      :prepend t :empty-lines-before 1)
     ("bi" "Idea" entry
      (file+headline "~/Dropbox/orgfiles/book-projects/book-ideas.org" "Ideas")
      (file "~/Dropbox/orgfiles/org-templates/tpl-book-idea.txt")
      :prepend t :empty-lines-before 1)
     ("r" "Research Notes")
     ("rt" "Text Note" entry
      (file+headline "~/Dropbox/orgfiles/notes.org" "Notes")
      (file "~/Dropbox/orgfiles/org-templates/tpl-text-note.txt")
      :prepend t :empty-lines-before 1)
     ("rl" "Link Note" entry
      (file+headline "~/Dropbox/orgfiles/links.org" "Links")
      (file "~/Dropbox/orgfiles/org-templates/tpl-link-note.txt")
      :prepend t :empty-lines-before 1)
     )
)

(defadvice org-capture-finalize 
   (after delete-capture-frame activate)  
    "Advise capture-finalize to close the frame"  
   (if (equal "capture" (frame-parameter nil 'name))  
       (delete-frame)))

(defadvice org-capture-destroy 
   (after delete-capture-frame activate)  
    "Advise capture-destroy to close the frame"  
   (if (equal "capture" (frame-parameter nil 'name))  
       (delete-frame)))  

(use-package noflet
   :ensure t )
     (defun make-capture-frame ()
      "Create a new frame and run org-capture."
      (interactive)
      (make-frame '((name . "capture")))
      (select-frame-by-name "capture")
      (delete-other-windows)
      (noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
        (org-capture))
)

(setq
 org-src-fontify-natively t
 org-src-tab-acts-natively t)

(setq org-latex-listings 'minted)

(setq org-latex-pdf-process (list "latexmk -f -pdf %f"))

(setq org-file-apps '((auto-mode . emacs)
                      ("\\.x?html?\\'" . "firefox %s")
                      ("\\.pdf\\'" . "evince \"%s\"")
                      ("\\.pdf::\\([0-9]+\\)\\'" . "evince \"%s\" -p %1")
                      ("\\.pdf.xoj" . "xournal %s")))

(setq org-file-apps '((auto-mode . emacs)
                      ("\\.x?html?\\'" . "firefox %s")
                      ("\\.pdf\\'" . "evince \"%s\"")
                      ("\\.pdf::\\([0-9]+\\)\\'" . "evince \"%s\" -p %1")
                      ("\\.pdf.xoj" . "xournal %s")))

;; Set up Environment for Clojure
;; First CIDER
(use-package cider
  :ensure t)
