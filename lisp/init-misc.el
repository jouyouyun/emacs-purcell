;;----------------------------------------------------------------------------
;; Misc config - yet to be placed in separate files
;;----------------------------------------------------------------------------
(add-auto-mode 'tcl-mode "Portfile\\'")
(fset 'yes-or-no-p 'y-or-n-p)

;; disable autosave
(setq auto-save-default nil)
;; disable backup file
(setq make-backup-files nil)
;; enable clipboard
(setq select-enable-clipboard t)
;; set environment coding system
(set-language-environment "UTF-8")
;; auto revert buffer globally
(global-auto-revert-mode t)

(add-hook 'prog-mode-hook 'goto-address-prog-mode)
(setq goto-address-mail-face 'link)

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(add-hook 'after-save-hook 'sanityinc/set-mode-for-new-scripts)

(defun sanityinc/set-mode-for-new-scripts ()
  "Invoke `normal-mode' if this file is a script and in `fundamental-mode'."
  (and
   (eq major-mode 'fundamental-mode)
   (>= (buffer-size) 2)
   (save-restriction
     (widen)
     (string= "#!" (buffer-substring (point-min) (+ 2 (point-min)))))
   (normal-mode)))


(setq-default regex-tool-backend 'perl)
(after-load 're-builder
  ;; Support a slightly more idiomatic quit binding in re-builder
  (define-key reb-mode-map (kbd "C-c C-k") 'reb-quit))

(add-auto-mode 'conf-mode "Procfile")


(require-package 'youdao-dictionary)
;; Enable Cache
(setq url-automatic-caching t)
(global-set-key (kbd "C-c M-\\") 'youdao-dictionary-search-at-point+)

(provide 'init-misc)
