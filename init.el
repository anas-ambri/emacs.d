;No files with annoying tildes, even if it means no backup
(setq make-backup-files nil)
;Copy & paste from clipboard
(setq x-select-enable-clipboard t)
;Window resizing
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)
;EJS files use html-mode
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . html-mode))

;magit
;;;;;;
(add-to-list 'load-path "~/.emacs.d/plugins/magit")
(require 'magit)

;nodejs-repl
;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/plugins/nodejs")
(require 'nodejs-repl)

; auto-complete, yasnippet, syntax checking and code folding based off
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

;syntax checking for js
;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/plugins/lintnode")
(require 'flymake-jslint)
(setq lintnode-location "/.emacs.d/plugins/lintnode" )
;exclude some error messages
(setq lintnode-jslint-excludes (list 'nomen 'plusplus 'onevar 'white))
; Add hooks for js and javascript modes
(add-hook 'js-mode-hook (lambda () (lintnode-hook)))
(add-hook 'javascript-mode-hook (lambda () (lintnode-hook)))
;flymake cursor to get error in message buffer
(add-to-list 'load-path "~/.emacs.d/modes/flymake-cursor")
(require 'flymake-cursor)

;Code folding
;;;;;;;;;;;;;
(add-hook 'js-mode-hook (lambda () (imenu-add-menubar-index) (hs-minor-mode t)))
(add-hook 'javascript-mode-hook (lambda () (imenu-add-menubar-index) (hs-minor-mode t)))
(global-set-key (kbd "C-x C-h") 'hs-show-block)
(global-set-key (kbd "C-x C-k") 'hs-hide-block)

;Adding eproject
;;;;;;;;;;;;;;;;
;(add-to-list 'load-path "~/.emacs.d/plugins/eproject")
;(require 'eproject)
;(require 'eproject-extras)

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
