;; -*- lexical-binding: t -*-

;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

(let ((minver "24.3"))
  (when (version< emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version< emacs-version "24.5")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-benchmarking) ;; Measure startup time

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

;;----------------------------------------------------------------------------
;; Adjust garbage collection thresholds during startup, and thereafter
;;----------------------------------------------------------------------------
(let ((normal-gc-cons-threshold (* 20 1024 1024))
      (init-gc-cons-threshold (* 128 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'after-init-hook
            (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;; Calls (package-initialize)
(require 'init-elpa)      ;; Machinery for installing required packages
(require 'init-exec-path) ;; Set up $PATH

;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-preload-local.el"
;;----------------------------------------------------------------------------
(require 'init-preload-local nil t)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------

(require-package 'scratch)
(require-package 'command-log-mode)
(require-package 'multi-term)
(require-package 'helm)
(require-package 'helm-firefox)
(require-package 'helm-ls-git)
;; (require-package 'wgrep)
;; (require-package 'ivy)
;; (require-package 'swiper)
;; (require-package 'counsel)

(require 'init-frame-hooks)
(require 'init-xterm)
(require 'init-themes)
(require 'init-gui-frames)
(require 'init-dired)
(require 'init-grep)
(require 'init-uniquify)
(require 'init-flycheck)

(require 'init-recentf)
(require 'init-helm)
;; (require 'init-ivy)
(require 'init-hippie-expand)
(require 'init-company)
(require 'init-window)
(require 'init-sessions)
(require 'init-mmm)

(require 'init-editor)
(require 'init-whitespace)
(require 'init-auto-insert)
(require 'init-tip)
;; (require 'init-pinyin) ;; not found, need add repo

(require 'init-vc)
;; (require 'init-darcs)
(require 'init-git)
;; (require 'init-github)

;; (require 'init-projectile)

(require 'init-c)
;; (require 'init-rtags)
(require 'init-textile)
(require 'init-markdown)
(require 'init-csv)
(require 'init-golang)
;; (require 'init-erlang)
(require 'init-javascript)
(require 'init-php)
(require 'init-org)
(require 'init-nxml)
(require 'init-html)
(require 'init-css)
;; (require 'init-haml)
(require 'init-http)
(require 'init-python)
;; (require 'init-haskell)
;; (require 'init-ruby-mode)
;; (require 'init-rails)
;; (require 'init-sql)
(require 'init-rust)
(require 'init-toml)
(require 'init-yaml)
(require 'init-docker)

(require 'init-lisp)
(require 'init-common-lisp)

(when *spell-check-support-enabled*
  (require 'init-spelling))

(require 'init-misc)

(require 'init-folding)
;; Extra packages which don't require any configuration

(require-package 'popup)
(require-package 'gnuplot)
(require-package 'lua-mode)
(require-package 'htmlize)
(require-package 'dsvn)
(when *is-a-mac*
  (require-package 'osx-location))
(maybe-require-package 'regex-tool)
(maybe-require-package 'dotenv-mode)

;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(require 'server)
(unless (server-running-p)
  (server-start))


;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(when (file-exists-p custom-file)
  (load custom-file))


;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-local" containing personal settings
;;----------------------------------------------------------------------------
(require 'init-local nil t)


;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'init-locales)


(when (maybe-require-package 'uptimes)
  (add-hook 'after-init-hook (lambda () (require 'uptimes))))

(wen-eval-after-init
 ;; greet the use with some useful tip
 (run-at-time 5 nil 'wen-tip-of-the-day))


(provide 'init)

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
