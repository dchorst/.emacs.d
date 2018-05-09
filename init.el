;; Init.el: --- dchorst init
;;; Commentary:

;;; Code:
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("elpy" . "https://jorgenschaefer.github.io/packages/")
        ("org" . "http://orgmode.org/elpa/")))

(setq package-enable-at-startup nil)
(package-initialize)

;; load path for other packages
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Moved the custom.el stuff into its own file called ~/.emacs.d/customize.el
(setq custom-file "~/.emacs.d/customize.el")
(load custom-file)

;; I borrowed this hostname function from Dennis Ogbe
;; Normally, I could use the =system-name= variable to get the current
;; hostname, but it seems to return the value of =hostname -f=, which is not
;; what I want. Therefore, I find the hostname manually by calling
;; =shell-command-to-string= and stripping some whitespace. This will probably
;; /not/ work on windows. Also, unfortunately, this hast to be defined before
;; tangling, since this is the variable we're checking while tangling
(setq hostname
   (replace-regexp-in-string "\\`[ \t\n]*" ""
      (replace-regexp-in-string "[ \t\n]*\\'" ""
         (shell-command-to-string "hostname"))))

;; ansi-term directory tracking breaks when "system-name" evaluates to
;; "ava.Home". This is a dirty fix, but it works for now. Maybe I can
;; investigate further into this one day.
(setq system-name hostname)

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; We will use a literate programming style for our customization of emacs
;; org-babel let's us have the bulk of our configuration in an org file

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))

;;; init.el ends here


