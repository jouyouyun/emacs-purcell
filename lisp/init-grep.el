(setq-default grep-highlight-matches t
              grep-scroll-output t)

(when *is-a-mac*
  (setq-default locate-command "mdfind"))

(when (and (executable-find "rg")
           (maybe-require-package 'rg))
  (global-set-key (kbd "M-?") 'rg-project))


(provide 'init-grep)
