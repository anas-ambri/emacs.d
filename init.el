;No files with annoying tildes, even if it means no backup
(setq make-backup-files nil)

;magit
(add-to-list 'load-path "~/.emacs.d/modes/magit")
(require 'magit)

;auto-complete based off
; http://blog.deadpansincerity.com/2011/05/setting-up-emacs-as-a-javascript-editing-environment-for-fun-and-profit/
(add-to-list 'load-path "~/.emacs.d/modes/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/dict")
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)
(setq ac-auto-start 2)
;ignore case when auto-completing
(setq ac-ignore-case t)