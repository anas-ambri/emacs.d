;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; turn on syntax highlighting
(global-font-lock-mode 1)

;No files with annoying tildes, even if it means no backup
(setq make-backup-files nil)

;Copy & paste from clipboard
(setq x-select-enable-clipboard t)

;EJS files use html-mode
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . html-mode))
;STYL files use css-mode
(add-to-list 'auto-mode-alist '("\\.styl\\'" . css-mode))
;JS files use js2-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;Converting tabs into spaces
(setq c-basic-indent 2)
(setq tab-width 4)
(setq indent-tabs-mode nil)

(setq mac-command-modifier 'meta)

;uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward
      uniquify-separator ":")

;column and line-mode
(setq line-number-mode t)
(setq column-number-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Hacks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Window resizing
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Modes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Ergoemacs : http://ergoemacs.github.io/ergoemacs-mode/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/modes/ergoemacs-mode")
(require 'ergoemacs-mode)
(setq ergoemacs-theme "lvl3") ;; Uses Standard Ergoemacs keyboard theme
(setq ergoemacs-mode-used "5.7.5")
(setq ergoemacs-use-menus t)
(setq ergoemacs-keyboard-layout "us") ;; Assumes QWERTY keyboard layout
(ergoemacs-mode 1)
;Custom commands
(ergoemacs-key "C-\'" 'newline-and-indent "Execute")


; Adding web-mode
;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/modes/web-mode")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))

;Adding android-mode
;;;;;;;;;;;;;;;;;;;;
;Based off http://wjlroe.github.io/2010/05/16/emacs-for-android-development.html
;For keybindings and how to setup project, see link.
; More info here: http://web.archive.org/web/20120321225744/http://riddell.us/AndroidWithEmacsOnUbuntu.html
(setq android-mode-sdk-dir "~/dev-tool/android-sdk/")
(add-to-list 'load-path "~/.emacs.d/modes/java-mode-indent-annotations")
(add-to-list 'load-path "~/.emacs.d/modes/android-mode")
(require 'android-mode)
(require 'java-mode-indent-annotations)

(add-hook 'java-mode-hook
      (function (lambda() (java-mode-indent-annotations-setup))))

;arduino-mode
;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/modes/arduino-mode")
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)

;octave-mode
;;;;;;;;;;;;
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(add-hook 'octave-mode-hook
	  (lambda ()
	    (abbrev-mode 1)
	    (auto-fill-mode 1)
	    (if (eq window-system 'x)
		(font-lock-mode 1))))
;Up and down arrows for previous commands
(add-hook 'inferior-octave-mode-hook
	  (lambda ()
	    (define-key inferior-octave-mode-map [up]
	      'comint-previous-input)
	    (define-key inferior-octave-mode-map [down]
	      'comint-next-input))) 

;json-mode
;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/modes/json-mode")
(require 'json-mode)
; beautify-json based off http://stackoverflow.com/questions/435847/emacs-mode-to-edit-json#answer-7934783
(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "python -mjson.tool" (current-buffer) t)))

;groovy-mode
;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/modes/groovy-mode")
(require 'groovy-mode)
;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

;;; make Groovy mode electric by default.
(add-hook 'groovy-mode-hook
          '(lambda ()
             (require 'groovy-electric)
             (groovy-electric-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Plugins
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;magit
;;;;;;
(add-to-list 'load-path "~/.emacs.d/plugins/magit")
(require 'magit)

;nodejs-repl
;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/plugins/nodejs")
(require 'nodejs-repl)

; auto-complete and yasnippet based off
; http://blog.deadpansincerity.com/2011/05/setting-up-emacs-as-a-javascript-editing-environment-for-fun-and-profit/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete/dict")
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)
(setq ac-auto-start 1)
;ignore case when auto-completing
(setq ac-ignore-case t)

;Snippeting
;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas/global-mode t)
;Taken from http://stackoverflow.com/questions/15774807/emacs-24-autocomplete-yasnippet
(setq ac-source-yasnippet nil)
(setq yas-snippet-dirs "~/.emacs.d/plugins/yasnippet/snippets")

;Adding eproject
;;;;;;;;;;;;;;;;
;(add-to-list 'load-path "~/.emacs.d/plugins/eproject")
;(require 'eproject)
;(require 'eproject-extras)

;Lookup documentation online
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Based off http://ergoemacs.org/emacs/emacs_lookup_ref.html
(add-to-list 'load-path "~/.emacs.d/plugins/lookup-word")
(require 'lookup-word)
(setq lookup-hash (make-hash-table :test 'equal))
(puthash "node" "http://www.google.com/search?q=nodejs+�" lookup-hash)
(puthash "nodejs" "http://www.google.com/search?q=nodejs+�" lookup-hash)
(puthash "juice" "https://github.com/LearnBoost/juice#documentation" lookup-hash)

(defun lookup-mode-specific (site &optional input-word)
  "Lookup current word or text selection depending on given site."
  (interactive "sEnter documentation site: ")
  (lookup-word-on-internet input-word (gethash site lookup-hash) ) )
